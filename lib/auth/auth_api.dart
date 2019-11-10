import 'dart:convert';

import 'package:robo_coffee_app/auth/auth_entity.dart';
import 'package:robo_coffee_app/base/http.dart';
import 'package:robo_coffee_app/config/app_config.dart';

abstract class AuthApi {
  Future<Credentials> authFirebase(FirebaseUserTokenCheckRequest request);

  Future<TokenResponse> getOAuthToken(
      String grantType, String login, String password);
}

class RemoteAuthApi extends AuthApi {
  AppConfig _appConfig;
  RestApiHttpClient _httpClient;

  RemoteAuthApi(this._appConfig, this._httpClient);

  @override
  Future<Credentials> authFirebase(
      FirebaseUserTokenCheckRequest request) async {
    var response = await _httpClient.post('/api/v1/auth/firebase',
        headers: {}, body: json.encode(request.toJson()));
    return Credentials.fromJson(json.decode(response.body));
  }

  @override
  Future<TokenResponse> getOAuthToken(
      String grantType, String login, String password) async {
    var client = _appConfig.apiBasicAuthUsername;
    var secret = _appConfig.apiBasicAuthPassword;

    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$client:$secret'));
    var response = await _httpClient.post(
        '/oauth/token?grant_type=$grantType&username=$login&password=$password',
        headers: {
          //'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
          'Authorization': basicAuth
        });

    return TokenResponse.fromJson(json.decode(response.body));
  }
}
