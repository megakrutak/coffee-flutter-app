import 'dart:async';
import 'package:coffee_flutter_app/auth/api.dart';
import 'package:coffee_flutter_app/auth/entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> sendPhone(String phone);

  Future<TokenResponse> sendCode(String code);

  Future<TokenResponse> getToken();

  Future<void> persistToken(TokenResponse token);

  Future<void> deleteToken();
}

class AuthRepositoryImpl implements AuthRepository {
  var _token;
  var _verificationId = "";
  AuthApi _authApi;

  AuthRepositoryImpl(this._authApi);

  @override
  Future<void> sendPhone(String phone) async {
    return await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredentials) {
          print(authCredentials);
        },
        verificationFailed: (AuthException authException) {
          throw authException;
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        });
  }

  @override
  Future<TokenResponse> sendCode(String code) async {
    var authCredentials = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: code);
    var authResult =
        await FirebaseAuth.instance.signInWithCredential(authCredentials);
    var tokenId = await authResult.user.getIdToken();
    var request = FirebaseUserTokenCheckRequest(tokenId.token);
    var credentials = await _authApi.authFirebase(request);
    var tokenResponse = await _authApi.getOAuthToken(
        "password", credentials.login, credentials.password);

    await persistToken(tokenResponse);

    return tokenResponse;
  }

  @override
  Future<TokenResponse> getToken() async {
    return Future.delayed(Duration(seconds: 2), () => _token);
  }

  @override
  persistToken(TokenResponse token) async {
    return Future.delayed(Duration(seconds: 2), () {
      _token = token;
    });
  }

  @override
  Future<void> deleteToken() async {
    return Future.delayed(Duration(seconds: 2), () {
      _token = null;
    });
  }
}
