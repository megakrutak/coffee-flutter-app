import 'dart:async';
import 'package:coffee_flutter_app/auth/data.dart';

abstract class AuthRepository {
  Future<bool> sendPhone(String phone);
  Future<TokenResponse> sendCode(String code);
}

class MockAuthRepository extends AuthRepository {
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

}