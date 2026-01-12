import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/errors/error_model.dart';
import 'package:doctor_booking_system_with_ai/core/errors/exceptions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AiChatRemoteDataSource {
  Stream<String> sendMessage(String message);
}

class AiChatRemoteDataSourceImpl implements AiChatRemoteDataSource {
  String? extractSpecialtyFromMessage(String message) {
    final regex = RegExp(r'###SPECIALTY:\s*(.+)$', multiLine: true);
    final match = regex.firstMatch(message);

    if (match != null) {
      return match.group(1)?.trim();
    }

    return null;
  }

  final Dio dio;
  final String _apiKey = dotenv.env['AI_API_KEY'] ?? '';

  AiChatRemoteDataSourceImpl({required this.dio});

  static const String _systemPrompt = """
أنت مساعد طبي ذكي ومتفاعل.
مهمتك تقديم استشارة طبية أولية بطريقة واضحة ومباشرة وباللغة العربية الفصيحة.

قواعد التنسيق المهمة:
- لا تستخدم أي أيقونات أو رموز مثل: 🔹 🔸 ① ② 🚨 🤖 ✨ 💡 🌿 أو غيرها.
- لا تستخدم رموز * أو # في النص.
- استخدم فقط الشرطة (-) للنقاط الفرعية.
- اكتب النص بشكل بسيط وواضح بدون تنسيقات خاصة.

قواعد عملك عند ذكر الأعراض:
1. اقرأ أعراض المستخدم بدقة.
2. قدم تشخيصاً مبدئياً مختصراً.
3. اذكر أهم النصائح العملية.
4. حدد إذا كانت الحالة تحتاج مراجعة طبيب أم لا.

في نهاية كل رد، أضف سطرًا أخيرًا فقط بالشكل التالي:
###SPECIALTY: <اسم_التخصص>

- يجب أن يكون اسم التخصص كلمة واحدة فقط.
- لا تضع أي نص بعد هذا السطر.
- إذا لم يكن هناك تخصص واضح، استخدم: ###SPECIALTY: عام

كن مختصراً وواضحاً.
""";

  @override
  Stream<String> sendMessage(String message) async* {
    if (_apiKey.isEmpty) {
      throw ServerException(
        ErrorModel(
          status: 401,
          errorMessage:
              "مفتاح API الخاص بالذكاء الاصطناعي مفقود. يرجى إضافته إلى ملف .env باسم AI_API_KEY.",
        ),
      );
    }

    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:streamGenerateContent?alt=sse&key=$_apiKey";

    log("🚀 AI Chat [STABLE]: Sending request to $url");
    log(
      "AI Chat: API Key starts with: ${_apiKey.isNotEmpty ? _apiKey.substring(0, 5) : 'EMPTY'}...",
    );

    final body = {
      "contents": [
        {
          "parts": [
            {"text": "$_systemPrompt\n\nسؤال المستخدم: $message"},
          ],
        },
      ],
    };

    try {
      final response = await dio.post(
        url,
        data: jsonEncode(body),
        options: Options(
          responseType: ResponseType.stream,
          headers: {"Content-Type": "application/json"},
          validateStatus: (status) =>
              true, // Don't throw to handle errors manually
        ),
      );

      if (response.statusCode != 200) {
        String errorContent = "";
        if (response.data is ResponseBody) {
          final responseBody = response.data as ResponseBody;
          final chunks = await responseBody.stream
              .cast<List<int>>()
              .transform(utf8.decoder)
              .toList();
          errorContent = chunks.join();
        }
        log("❌ AI Chat: Error ${response.statusCode} - $errorContent");

        throw ServerException(
          ErrorModel(
            status: response.statusCode ?? 500,
            errorMessage: "خطأ من السيرفر: $errorContent",
          ),
        );
      }

      final stream = (response.data as ResponseBody).stream
          .cast<List<int>>()
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      await for (final line in stream) {
        if (line.trim().isEmpty) continue;

        log("RAW LINE: $line");

        if (!line.startsWith('data:')) continue;

        final jsonStr = line.replaceFirst('data:', '').trim();

        if (jsonStr == '[DONE]') {
          log('✅ Stream finished');
          break;
        }

        try {
          final Map<String, dynamic> data = jsonDecode(jsonStr);

          final candidates = data['candidates'];
          if (candidates == null || candidates.isEmpty) continue;

          final content = candidates[0]['content'];
          if (content == null) continue;

          final parts = content['parts'];
          if (parts == null || parts.isEmpty) continue;

          final text = parts[0]['text'];
          if (text == null || text.toString().trim().isEmpty) continue;

          log('✅ YIELD TEXT: $text');
          final aiMessage = text.toString();

          final String? specialty = extractSpecialtyFromMessage(aiMessage);

          if (specialty != null && specialty != 'عام') {
            print(
              "**************************************************************",
            );
            print('التخصص المستخرج: $specialty');
            print(
              "**************************************************************",
            );
            // أرسله إلى Laravel
          }

          yield text.toString();
        } catch (e) {
          log('❌ JSON Parse Error: $e');
        }
      }
    } catch (e) {
      if (e is ServerException) rethrow;

      log("🚨 AI Chat Error: $e");
      throw ServerException(
        ErrorModel(status: 500, errorMessage: "فشل التحميل: $e"),
      );
    }
  }
}
