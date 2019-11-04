import 'dart:convert';

import 'package:coffee_flutter_app/auth/entity.dart';
import 'package:coffee_flutter_app/base/http.dart';
import 'package:coffee_flutter_app/config/app_config.dart';

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
        headers: {}, body: request.toJson());
    return Credentials.fromJson(json.decode(response.body));
  }

  @override
  Future<TokenResponse> getOAuthToken(
      String grantType, String login, String password) async {
    var username = _appConfig.apiBasicAuthUsername;
    var password = _appConfig.apiBasicAuthPassword;

    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await _httpClient
        .post('/oauth/token', headers: {'Authorization': basicAuth});

    return TokenResponse.fromJson(json.decode(response.body));
  }
}
