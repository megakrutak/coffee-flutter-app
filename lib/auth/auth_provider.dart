
import 'package:robo_coffee_app/auth/auth_entity.dart';
import 'package:robo_coffee_app/auth/auth_token_storage.dart';

abstract class AuthProvider {
  Future<bool> isAuthorized();
  Future<String> getAccessToken();
  Future<String> getBearer();
}

class AppAuthProvider implements AuthProvider {
  TokenStorage _tokenStorage;
  TokenResponse _tokenResponse;

  AppAuthProvider(this._tokenStorage);

  @override
  Future<String> getAccessToken() async {
    if (_tokenResponse == null) {
      return (await _getTokenFromCache())?.accessToken ?? null;
    }

    return _tokenResponse.accessToken;
  }

  @override
  Future<String> getBearer() async {
    if (_tokenResponse == null) {
      return (await _getTokenFromCache())?.type ?? null;
    }

    return _tokenResponse.type;
  }

  @override
  Future<bool> isAuthorized() async {
    if (_tokenResponse != null) {
      return true;
    }

    var token = await _getTokenFromCache();
    return token != null;
  }

  Future<TokenResponse> _getTokenFromCache() async {
    var token = await _tokenStorage.readToken();
    if (token != null) {
      _tokenResponse = token;
    }
    return token;
  }
}