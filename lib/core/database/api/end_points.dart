import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static String ip = dotenv.env['APP_IP'] ?? '127.0.0.1';
  static String port = dotenv.env['APP_PORT'] ?? '8000';

  static String get baseUrl {
    if (ip.startsWith('http')) {
      // If it's a full URL, use it directly. Remove trailing slash if present.
      String cleanIp = ip.endsWith('/') ? ip.substring(0, ip.length - 1) : ip;
      // If port is specified and not 80 (http) or 443 (https), we might append it,
      // but usually if a domain is provided, port is handled by DNS/Proxy.
      // Let's assume if it is a domain with https, we don't need port 8000 unless specified in the URL itself.
      return "$cleanIp/api/v1/";
    }
    return "http://$ip:$port/api/v1/";
  }

  static String get photoUrl {
    if (ip.startsWith('http')) {
      String cleanIp = ip.endsWith('/') ? ip.substring(0, ip.length - 1) : ip;
      return "$cleanIp/storage";
    }
    return "http://$ip:$port/storage";
  }
}
