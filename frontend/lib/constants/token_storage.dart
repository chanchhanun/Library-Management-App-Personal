import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final token = '';
  final storage = FlutterSecureStorage();

  // get token
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  // set token
  Future<void> setToken(String newToken) async {
    storage.write(key: 'token', value: newToken);
  }

  // clear token
  Future<void> clearToken() async {
    storage.delete(key: 'token');
  }
}
