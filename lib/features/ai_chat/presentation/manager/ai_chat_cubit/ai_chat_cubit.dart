import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:doctor_booking_system_with_ai/core/errors/exceptions.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/data/data_sources/ai_image_service.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_state.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/widget/recommended_doctors_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final AiChatRepository aiChatRepository;
  final DoctorRepo doctorRepo;
  final SpecialtyRepo specialtyRepo;

  final List<Map<String, dynamic>> _messages = [];
  final Map<int, List<Doctor>> _recommendedDoctors = {};
  List<Specialty> _specialties = [];
  StreamSubscription? _chatSubscription;

  AiChatCubit({
    required this.aiChatRepository,
    required this.doctorRepo,
    required this.specialtyRepo,
  }) : super(AiChatInitial()) {
    _loadSpecialties();
  }

  Future<void> _loadSpecialties() async {
    final result = await specialtyRepo.getSpecialties();
    result.fold(
      (failure) {
        log('Failed to load specialties from API, trying cache...');
        _loadSpecialtiesFromCache();
      },
      (specialties) {
        _specialties = specialties;
        log('Loaded ${_specialties.length} specialties from API');
        for (var s in _specialties) {
          log('Specialty: ${s.name} (ID: ${s.id})');
        }
      },
    );
  }

  void _loadSpecialtiesFromCache() {
    final specialtyBox = Hive.box<Specialty>(kSpecialtyBox);
    _specialties = specialtyBox.values.toList();
    log('Loaded ${_specialties.length} specialties from cache');
  }

  // تطبيع النص العربي - توحيد أشكال الحروف
  String _normalizeArabic(String text) {
    return text
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ٱ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ي')
        // إزالة التشكيل
        .replaceAll(RegExp(r'[\u064B-\u065F]'), '')
        .trim();
  }

  List<int> _extractSpecialtyIds(String text) {
    final List<int> foundIds = [];
    
    // 1. البحث عن ###SPECIALTY marker (الأولوية القصوى)
    final markerRegex = RegExp(
      r'###SPECIALTY:\s*([^\n]+)',
      caseSensitive: false,
    );
    final match = markerRegex.firstMatch(text);
    if (match != null) {
      final extractedContent = match.group(1)?.trim() ?? '';
      log('Found specialty marker content: "$extractedContent"');
      
      // تقسيم التخصصات إذا كانت متعددة
      final potentialSpecialties = extractedContent.split(RegExp(r'[,،]'));
      
      for (var specName in potentialSpecialties) {
        final cleanSpecName = specName.trim().replaceAll('_', ' ');
        final normalizedSpec = _normalizeArabic(cleanSpecName);
        
        for (final specialty in _specialties) {
          final normalizedSpecialtyName = _normalizeArabic(specialty.name);
          if (normalizedSpec.contains(normalizedSpecialtyName) || 
              normalizedSpecialtyName.contains(normalizedSpec)) {
            if (!foundIds.contains(specialty.id)) {
              log('✅ Marker Match: ${specialty.name} (ID: ${specialty.id})');
              foundIds.add(specialty.id);
            }
          }
        }
      }
    }

    // إذا لم نجد شيئاً في الـ marker، لا نقوم بالتخمين التلقائي إلا إذا كان النص قصيراً جداً أو يحتوي على كلمات مفتاحية قوية جداً
    // ولكن بناءً على طلب المستخدم، سنعتمد أساساً على الـ marker أو طلبات صريحة.
    
    return foundIds;
  }

  List<Doctor> _fetchDoctorsBySpecialtyFromCache(int specialtyId) {
    final doctorBox = Hive.box<Doctor>(kDoctorBox);
    final allDoctors = doctorBox.values.toList();
    log('Total doctors in cache: ${allDoctors.length}');

    final filteredDoctors = allDoctors
        .where((doctor) => doctor.specialtyId == specialtyId)
        .take(5)
        .toList();

    log(
      'Filtered doctors for specialty $specialtyId: ${filteredDoctors.length}',
    );
    return filteredDoctors;
  }

  List<Doctor> _findDoctorsByKeywords(List<String> keywords) {
    final List<Doctor> found = [];
    for (final keyword in keywords) {
      final normalizedKeyword = _normalizeArabic(keyword);
      for (final specialty in _specialties) {
        final normalizedName = _normalizeArabic(specialty.name);
        if (normalizedName.contains(normalizedKeyword) ||
            normalizedKeyword.contains(normalizedName)) {
          found.addAll(_fetchDoctorsBySpecialtyFromCache(specialty.id));
        }
      }
    }
    return {for (var d in found) d.id: d}.values.toList();
  }

  Future<void> sendMessage({String? message, File? image}) async {
    if (_specialties.isEmpty) {
      await _loadSpecialties();
    }

    // ================= IMAGE =================
    if (image != null) {
      _messages.add({'role': 'user', 'image': image, 'isDone': true});
      _messages.add({'role': 'ai', 'text': '', 'isDone': false});
      final int aiIndex = _messages.length - 1;

      emit(
        AiChatSuccess(
          messages: List.from(_messages),
          recommendedDoctors: Map.from(_recommendedDoctors),
          isGenerating: true,
        ),
      );

      try {
        final result = await ImageAiService().analyzeImage(image);

        if (_messages.length > aiIndex && _messages[aiIndex]['role'] == 'ai') {
          _messages[aiIndex]['text'] = result;
          _messages[aiIndex]['isDone'] = true;
        }

        final specialtyIds = _extractSpecialtyIds(result);
        log('Image analysis - extracted specialty IDs: $specialtyIds');

        if (specialtyIds.isNotEmpty) {
          List<Doctor> allDoctors = [];
          for (var id in specialtyIds) {
            allDoctors.addAll(_fetchDoctorsBySpecialtyFromCache(id));
          }
          final uniqueDoctors = {for (var d in allDoctors) d.id: d}.values.toList();
          if (uniqueDoctors.isNotEmpty) {
            _recommendedDoctors[aiIndex] = uniqueDoctors;
            log('✅ Image: Added ${uniqueDoctors.length} doctors at index $aiIndex');
          }
        } else {
          // Fallback: image analysis is for chest X-rays, try matching chest specialty
          final chestDoctors = _findDoctorsByKeywords(['صدر', 'باطن', 'صدريه', 'باطنيه']);
          if (chestDoctors.isNotEmpty) {
            _recommendedDoctors[aiIndex] = chestDoctors;
            log('✅ Image fallback: Added ${chestDoctors.length} chest doctors at index $aiIndex');
          }
        }

        emit(
          AiChatSuccess(
            messages: List.from(_messages),
            recommendedDoctors: Map.from(_recommendedDoctors),
            isGenerating: true, // Keep it true until typing finishes
          ),
        );
      } catch (e) {
        if (_messages.length > aiIndex && _messages[aiIndex]['role'] == 'ai') {
          _messages.removeAt(aiIndex);
        }
        emit(AiChatFailure(errMessage: e.toString()));
      }

      return;
    }

    // ================= TEXT =================
    if (message == null || message.isEmpty) return;

    _messages.add({'role': 'user', 'text': message, 'isDone': false});
    emit(
      AiChatSuccess(
        messages: List.from(_messages),
        recommendedDoctors: Map.from(_recommendedDoctors),
        isGenerating: true,
      ),
    );

    _messages.add({'role': 'ai', 'text': '', 'isDone': false});
    int aiIndex = _messages.length - 1;

    emit(
      AiChatSuccess(
        messages: List.from(_messages),
        recommendedDoctors: Map.from(_recommendedDoctors),
      ),
    );

    try {
      final history = _messages
          .where((m) => m['text'] != null && (m['text'] as String).isNotEmpty)
          .map((m) => {'role': m['role'], 'text': m['text']})
          .toList();

      final stream = aiChatRepository.sendMessage(history);

      _chatSubscription = stream.listen(
        (chunk) {
          final currentText = _messages[aiIndex]['text'] ?? '';
          _messages[aiIndex]['text'] = currentText + chunk;
          emit(
            AiChatSuccess(
              messages: List.from(_messages),
              recommendedDoctors: Map.from(_recommendedDoctors),
              isGenerating: true,
            ),
          );
        },
        onError: (error) {
          _chatSubscription = null;
          String errorMessage = error.toString();
          if (error is ServerException) {
            errorMessage = error.errorModel.errorMessage;
          }
          log('Error in stream: $errorMessage');
          emit(AiChatFailure(errMessage: errorMessage));
        },
        onDone: () async {
          _chatSubscription = null;
          log('========== STREAM DONE ==========');
          _messages[aiIndex]['isDone'] = true;

          final responseText = _messages[aiIndex]['text'] ?? '';
          log(
            'Specialties available: ${_specialties.map((s) => s.name).toList()}',
          );

          final specialtyIds = _extractSpecialtyIds(responseText);
          log('Final extracted specialty IDs: $specialtyIds');

          if (specialtyIds.isNotEmpty) {
            List<Doctor> allRecommendedDoctors = [];
            for (var id in specialtyIds) {
              final doctors = _fetchDoctorsBySpecialtyFromCache(id);
              allRecommendedDoctors.addAll(doctors);
            }
            
            // إزالة التكرار إن وجد
            final uniqueDoctors = { for (var d in allRecommendedDoctors) d.id : d }.values.toList();

            log('Fetched ${uniqueDoctors.length} unique doctors from all specialties');
            if (uniqueDoctors.isNotEmpty) {
              _recommendedDoctors[aiIndex] = uniqueDoctors;
              log(
                '✅ SUCCESS! Added ${uniqueDoctors.length} doctors to index $aiIndex',
              );
            }
          }

          log('Recommended doctors keys: ${_recommendedDoctors.keys.toList()}');

          emit(
            AiChatSuccess(
              messages: List.from(_messages),
              recommendedDoctors: Map.from(_recommendedDoctors),
              isGenerating: true, // Keep it true until typing finishes
            ),
          );
        },
      );
    } catch (e) {
      log('Error initiating stream: $e');
      emit(AiChatFailure(errMessage: e.toString()));
    }
  }

  void onTypingFinished() {
    // Only stop generation state if the stream is already done
    if (_chatSubscription == null) {
      emit(
        AiChatSuccess(
          messages: List.from(_messages),
          recommendedDoctors: Map.from(_recommendedDoctors),
          isGenerating: false,
        ),
      );
    }
  }

  void stopGeneration() {
    if (_chatSubscription != null) {
      _chatSubscription!.cancel();
      _chatSubscription = null;
      log('========== STREAM MANUALLY STOPPED ==========');
    }
      
    if (_messages.isNotEmpty && _messages.last['role'] == 'ai') {
      _messages.last['isDone'] = true;
    }

    emit(
      AiChatSuccess(
        messages: List.from(_messages),
        recommendedDoctors: Map.from(_recommendedDoctors),
        isGenerating: false,
      ),
    );
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
