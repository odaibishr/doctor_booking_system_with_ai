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
  final Dio dio;
  final String _apiKey = dotenv.env['AI_API_KEY'] ?? '';

  AiChatRemoteDataSourceImpl({required this.dio});

  static const String _systemPrompt = """
أنت مساعد طبي ذكي ومتفاعل.
مهمتك تقديم استشارة طبية أولية بطريقة جذابة ومباشرة وباللغة العربية الفصيحة.


قواعد عملك عند ذكر الأعراض:
1. اقرأ أعراض المستخدم بدقة واربط ردّك بها فقط، بدون افتراضات إضافية.
2. قدم تشخيصاً مبدئياً.
3. اذكر أهم أعراض شائعة مرتبطة بالحالة (بنقاط).
4. قدم عدة نصائح عملية فورية يمكنه فعلها الآن.
5. اعطيه حلول طبيعية يمكنه استخدامها
6. اعطيه التخصص الطبي الذي يجب زيارته
7. حدد بوضوح إذا كانت الحالة:
   - لا تحتاج طبيباً، أو
   - تحتاج مراجعة طبيب، او طارئه  .

قواعد الرد:
- استبدل دائمًا رموز النجمة (*) في القوائم بأيقونات أو ترقيمات ملونة من اختيارك (مثل: ①، ②، 🔹، 🔸).
- عند ذكر معلومات طبية مهمة أو تحذير صحي، أضف رمز 🚨 قبل الجملة.
- عند ذكر نصائح عامة أو إرشادات، أضف رمز 💡 قبل الجملة.
- عند أي عبارة تشير لدورك كمساعد ذكي، أضف رمز 🤖 تلقائيًا.
- نسّق النقاط بشكل جميل وواضح واجعل المخرجات جذابة بصريًا.
- التزم بهذه القواعد في كل إجابة دون استثناء.
- كن جذاباً وسريعاً وواضحاً وتجنب الشرح الطويل.
- إذا كان السؤال غير طبي، قل:
  "أنا مساعد طبي فقط ولا أستطيع الإجابة على هذا السؤال."
- في كل إجابة نهائية أضف الجملة التالية:
  "هذه المعلومات ليست دقيقة 100% لذلك لا تعتمد عليها بشكل كامل."
- في الاجابه اضف  اشكال للرموز او الترقيم او الفواصل بشكل انيق.
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
        log("RAW LINE: $line"); // لنتحقق مما يصل فعلياً

        if (line.startsWith('data: ')) {
          final jsonStr = line.substring(6);
          if (jsonStr.trim() == '[DONE]') break;

          try {
            final data = jsonDecode(jsonStr);
            // Gemini sometimes sends errors inside the 200 OK stream
            if (data["error"] != null) {
              log("❌ AI Chat Stream Error: ${data["error"]["message"]}");
              continue;
            }

            final candidates = data["candidates"] as List?;
            if (candidates != null && candidates.isNotEmpty) {
              final content = candidates[0]["content"];
              if (content != null) {
                final parts = content["parts"] as List?;
                if (parts != null && parts.isNotEmpty) {
                  final text = parts[0]["text"] as String?;
                  if (text != null) {
                    yield text;
                  }
                }
              }
            }
          } catch (e) {
            log("Parsing Error: $e");
          }
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
