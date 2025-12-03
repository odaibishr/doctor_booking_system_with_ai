import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static String ip = dotenv.env['APP_IP'] ?? '127.0.0.1';
  static String port = dotenv.env['APP_PORT'] ?? '8000';
  static String photoUrl = "http://$ip:$port/storage";
  static String baseUrl = "http://$ip:$port/api/v1/";
}
