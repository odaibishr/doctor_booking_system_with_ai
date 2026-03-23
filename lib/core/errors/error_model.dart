class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map jsonData) {
    String? errorMessage;
    if (jsonData['errors'] != null && jsonData['errors'] is Map) {
      final errors = jsonData['errors'] as Map;
      if (errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          errorMessage = firstError.first.toString();
        } else {
          errorMessage = firstError.toString();
        }
      }
    }
    
    return ErrorModel(
      errorMessage: errorMessage ?? jsonData["message"] ?? jsonData["Message"] ?? "حدث خطأ ما",
      status: jsonData["status"] ?? 400,
    );
  }
}
