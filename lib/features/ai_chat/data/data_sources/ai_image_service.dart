import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageAiService {
  final Dio dio = Dio();
  final String _apiKey = dotenv.env['AI_API_KEY'] ?? '';

  Future<String> analyzeImage(File image) async {
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro:generateContent?key=$_apiKey";

    final body = {
      "contents": [
        {
          "parts": [
            {
            "text": """
            أنت طبيب أشعة متخصص فقط في تحليل صور أشعة الصدر (Chest X-ray).

            مهمتك:
            تحليل الصورة بدقة شديدة والتمييز بين الأمراض التالية فقط:
            - التهاب رئوي
            - سل رئوي
            - انصباب جنبي
            - استرواح صدري
            - تضخم قلبي
            - سليم

            قواعد مهمة للتشخيص:
            - لا تشخص السل الرئوي اذكر التهاب رئوي.
            - إذا لم توجد علامات مرضية واضحة → سليم.

            طريقة الرد (إلزامية):
            نوع المرض: (اكتب اسم المرض فقط)
            شرح مختصر.
            إذا لم تكن الصورة أشعة صدر واضحة:
            اكتب فقط:
           لا أستطيع سوى تحليل كشافات الصدر وسأتعلم ذلك قريبا
            """
            },
            {
              "inlineData": {
                "mimeType": "image/jpeg",
                "data": base64Image,
              }
            }
          ]
        }
      ]
    };

    final response = await dio.post(url, data: body);

    final text =
        response.data['candidates'][0]['content']['parts'][0]['text'];

    return text;
  }
}