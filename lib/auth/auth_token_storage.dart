import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:robo_coffee_app/auth/auth_entity.dart';

abstract class TokenStorage {
  Future<TokenResponse> readToken();
  Future<void> writeToken(TokenResponse token);
  Future<void> deleteToken();
}

class SecureTokenStorage implements TokenStorage {

  FlutterSecureStorage _secureStorage;

  SecureTokenStorage(this._secureStorage);

  @override
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: "token");
  }

  @override
  Future<TokenResponse> readToken() async {
    var data = await _secureStorage.read(key: "token");
    return TokenResponse.fromJson(json.decode(data));
  }

  @override
  Future<void> writeToken(TokenResponse token) async {
    await _secureStorage.write(
        key: "token",
        value: json.encode(token.toJson())
    );
  }
}

class FakeTokenStorage implements TokenStorage {

  TokenResponse _token;

  @override
  Future<void> deleteToken() {
    return Future.delayed(Duration(seconds: 3), () {
      _token = null;
    });
  }

  @override
  Future<TokenResponse> readToken() {
    return Future.delayed(Duration(seconds: 3), () {
      return _token;
    });
  }

  @override
  Future<void> writeToken(TokenResponse token) {
    return Future.delayed(Duration(seconds: 3), () {
      _token = token;
    });
  }

}