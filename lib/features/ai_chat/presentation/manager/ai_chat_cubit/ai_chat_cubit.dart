import 'dart:developer';
import 'package:doctor_booking_system_with_ai/core/errors/exceptions.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/domain/repositories/ai_chat_repository.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/manager/ai_chat_cubit/ai_chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final AiChatRepository aiChatRepository;
  final DoctorRepo doctorRepo;
  final SpecialtyRepo specialtyRepo;

  final List<Map<String, dynamic>> _messages = [];
  final Map<int, List<Doctor>> _recommendedDoctors = {};
  List<Specialty> _specialties = [];

  // قائمة الكلمات المفتاحية لكل تخصص
  static const Map<String, List<String>> _specialtyKeywords = {
    'مخ واعصاب': [
      'أعصاب',
      'اعصاب',
      'عصب',
      'مخ',
      'دماغ',
      'صداع',
      'عصبي',
      'طب_الأعصاب',
      'طب الأعصاب',
    ],
    'القلب': ['قلب', 'قلبي', 'شرايين', 'ضغط الدم', 'نبض'],
    'باطنية': ['باطنة', 'باطني', 'معدة', 'هضمي', 'كبد', 'أمعاء'],
    'جراحة التجميل': ['تجميل', 'جراحة تجميلية', 'بشرة'],
    'جراحة عظام': ['عظام', 'عظم', 'مفاصل', 'كسر', 'عمود فقري'],
    'أسنان': ['أسنان', 'سن', 'ضرس', 'لثة', 'فم'],
    'عيون': ['عيون', 'عين', 'نظر', 'رؤية', 'بصر'],
    'جلدية': ['جلد', 'جلدي', 'بشرة', 'حساسية جلدية'],
    'أطفال': ['أطفال', 'طفل', 'رضيع'],
    'نساء وتوليد': ['نساء', 'توليد', 'حمل', 'رحم'],
  };

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

  int? _extractSpecialtyId(String text) {
    final normalizedText = _normalizeArabic(text);
    log('Searching for specialty in text...');

    // 1. البحث المباشر عن اسم التخصص في النص
    for (final specialty in _specialties) {
      final specialtyName = specialty.name;
      final normalizedSpecialty = _normalizeArabic(specialtyName);
      if (normalizedText.contains(normalizedSpecialty) ||
          text.contains(specialtyName)) {
        log(
          '✅ Found exact specialty match: ${specialty.name} (ID: ${specialty.id})',
        );
        return specialty.id;
      }
    }

    // 2. البحث عن الكلمات المفتاحية
    for (final specialty in _specialties) {
      final specialtyName = specialty.name;

      // البحث في قائمة الكلمات المفتاحية المحددة مسبقاً
      if (_specialtyKeywords.containsKey(specialtyName)) {
        final keywords = _specialtyKeywords[specialtyName]!;
        for (final keyword in keywords) {
          final normalizedKeyword = _normalizeArabic(keyword);
          if (normalizedText.contains(normalizedKeyword) ||
              text.contains(keyword)) {
            log(
              '✅ Found keyword "$keyword" for specialty: $specialtyName (ID: ${specialty.id})',
            );
            return specialty.id;
          }
        }
      }

      // البحث عن كلمات من اسم التخصص نفسه
      final specialtyWords = specialtyName.split(RegExp(r'\s+'));
      for (final word in specialtyWords) {
        if (word.length > 2) {
          // إزالة واو العطف
          String cleanWord = word;
          if (word.startsWith('و') && word.length > 1) {
            cleanWord = word.substring(1);
          }

          if (text.contains(word) || text.contains(cleanWord)) {
            log(
              '✅ Found word "$word" for specialty: $specialtyName (ID: ${specialty.id})',
            );
            return specialty.id;
          }
        }
      }
    }

    // 3. البحث عن ###SPECIALTY marker
    final markerRegex = RegExp(
      r'###SPECIALTY:\s*([^\n]+)',
      caseSensitive: false,
    );
    final match = markerRegex.firstMatch(text);
    if (match != null) {
      final extractedName = match.group(1)?.trim().replaceAll('_', ' ') ?? '';
      log('Found marker: "$extractedName"');

      // البحث عن تطابق جزئي
      for (final specialty in _specialties) {
        final specialtyName = specialty.name;
        final extractedWords = extractedName.split(RegExp(r'[\s_]+'));

        for (final word in extractedWords) {
          if (word.length > 2) {
            if (specialtyName.contains(word) ||
                _keywordMatchesSpecialty(word, specialtyName)) {
              log(
                '✅ Marker word "$word" matched specialty: $specialtyName (ID: ${specialty.id})',
              );
              return specialty.id;
            }
          }
        }
      }
    }

    log('⚠️ No specialty found in text');
    return null;
  }

  bool _keywordMatchesSpecialty(String keyword, String specialtyName) {
    if (_specialtyKeywords.containsKey(specialtyName)) {
      final keywords = _specialtyKeywords[specialtyName]!;
      for (final k in keywords) {
        if (k.contains(keyword) || keyword.contains(k)) {
          return true;
        }
      }
    }
    return false;
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

  Future<void> sendMessage(String message) async {
    if (_specialties.isEmpty) {
      await _loadSpecialties();
    }

    _messages.add({'role': 'user', 'text': message, 'isDone': false});
    emit(
      AiChatSuccess(
        messages: List.from(_messages),
        recommendedDoctors: Map.from(_recommendedDoctors),
      ),
    );

    _messages.add({'role': 'ai', 'text': ''});
    int aiIndex = _messages.length - 1;

    emit(
      AiChatSuccess(
        messages: List.from(_messages),
        recommendedDoctors: Map.from(_recommendedDoctors),
      ),
    );

    try {
      final stream = aiChatRepository.sendMessage(message);

      stream.listen(
        (chunk) {
          final currentText = _messages[aiIndex]['text'] ?? '';
          _messages[aiIndex]['text'] = currentText + chunk;
          emit(
            AiChatSuccess(
              messages: List.from(_messages),
              recommendedDoctors: Map.from(_recommendedDoctors),
            ),
          );
        },
        onError: (error) {
          String errorMessage = error.toString();
          if (error is ServerException) {
            errorMessage = error.errorModel.errorMessage;
          }
          log('Error in stream: $errorMessage');
          emit(AiChatFailure(errMessage: errorMessage));
        },
        onDone: () async {
          log('========== STREAM DONE ==========');
          _messages[aiIndex]['isDone'] = true;

          final responseText = _messages[aiIndex]['text'] ?? '';
          log(
            'Specialties available: ${_specialties.map((s) => s.name).toList()}',
          );

          final specialtyId = _extractSpecialtyId(responseText);
          log('Final extracted specialty ID: $specialtyId');

          if (specialtyId != null) {
            final doctors = _fetchDoctorsBySpecialtyFromCache(specialtyId);
            log('Fetched ${doctors.length} doctors');
            if (doctors.isNotEmpty) {
              _recommendedDoctors[aiIndex] = doctors;
              log(
                '✅ SUCCESS! Added ${doctors.length} doctors to index $aiIndex',
              );
            } else {
              log('⚠️ No doctors found for this specialty');
            }
          }

          log('Recommended doctors keys: ${_recommendedDoctors.keys.toList()}');

          emit(
            AiChatSuccess(
              messages: List.from(_messages),
              recommendedDoctors: Map.from(_recommendedDoctors),
            ),
          );
        },
      );
    } catch (e) {
      log('Error initiating stream: $e');
      emit(AiChatFailure(errMessage: e.toString()));
    }
  }
}
