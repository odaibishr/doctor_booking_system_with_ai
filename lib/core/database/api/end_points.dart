import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static String ip = dotenv.env['APP_IP'] ?? '127.0.0.1';
  static String port = dotenv.env['APP_PORT'] ?? '8000';
  static String get _cleanIp =>
      ip.endsWith('/') ? ip.substring(0, ip.length - 1) : ip;
  static String get _base {
    if (_cleanIp.startsWith('http')) {
      if (_cleanIp.contains('.com') ||
          _cleanIp.contains('.net') ||
          _cleanIp.contains('.org')) {
        return _cleanIp;
      }
      return "$_cleanIp:$port";
    }
    return "http://$_cleanIp:$port";
  }

  static String get photoUrl => "$_base/storage";
  static String get baseUrl => "$_base/api/v1/";
}
