class EndPoints {
  static String ip = dotenv.env['APP_IP'] ?? '127.0.0.1';
  static String port = dotenv.env['APP_PORT'] ?? '8000';

  static String get baseUrl {
    if (ip.startsWith('http')) {
       // ... بقية الكود الذكي ...
       return "$cleanIp/api/v1/";
    }
    return "http://$ip:$port/api/v1/";
  }

  static String get photoUrl {
    if (ip.startsWith('http')) {
       // ... بقية الكود الذكي ...
       return "$cleanIp/storage";
    }
    return "http://$ip:$port/storage";
  }
}