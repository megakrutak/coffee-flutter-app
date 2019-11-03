import 'dart:async';
import 'package:coffee_flutter_app/auth/data.dart';

abstract class AuthRepository {
  Future<bool> sendPhone(String phone);
  Future<TokenResponse> sendCode(String code);
  Future<TokenResponse> getToken();
  Future<void>persistToken(TokenResponse token);
  Future<void>deleteToken();
}

class MockedAuthRepository implements AuthRepository {
  var _token;

  @override
  Future<TokenResponse> sendCode(String code) async {
    Future.delayed(Duration(seconds: 3));
    return TokenResponse("access_token", "bearer", "refresh_token");
  }

  @override
  Future<bool> sendPhone(String phone) async {
    Future.delayed(Duration(seconds: 2));
    return true;
  }

  @override
  Future<TokenResponse> getToken() async {
    Future.delayed(Duration(seconds: 1));
    return _token;
  }

  @override
  persistToken(TokenResponse token) async  {
    Future.delayed(Duration(seconds: 1));
    _token = token;
  }

  @override
  Future<void> deleteToken() async {
    _token = null;
  }

}