// lib/core/auth/i_token_storage.dart

abstract class ITokenStorage {
  Future<String?> getToken();
}
