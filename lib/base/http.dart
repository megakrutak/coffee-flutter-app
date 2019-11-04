import 'dart:convert';
import 'package:coffee_flutter_app/auth/auth_provider.dart';
import 'package:coffee_flutter_app/config/app_config.dart';
import 'package:http/http.dart' as http;

class RestApiHttpClient {
  AppConfig _appConfig;
  AuthProvider _authProvider;

  RestApiHttpClient(this._appConfig, this._authProvider);

  Future<http.Response> delete(url, {Map<String, String> headers}) {
    return http.delete(_getBaseUrl() + url, headers: _modifyHeaders(headers));
  }

  Future<http.Response> get(url, {Map<String, String> headers}) {
    return http.get(_getBaseUrl() + url, headers: _modifyHeaders(headers));
  }

  Future<http.Response> head(url, {Map<String, String> headers}) {
    return http.head(_getBaseUrl() + url, headers: _modifyHeaders(headers));
  }

  Future<http.Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return http.patch(_getBaseUrl() + url,
        headers: _modifyHeaders(headers), body: body, encoding: encoding);
  }

  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return http.post(_getBaseUrl() + url,
        headers: _modifyHeaders(headers), body: body, encoding: encoding);
  }

  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return http.put(_getBaseUrl() + url,
        headers: _modifyHeaders(headers), body: body, encoding: encoding);
  }

  String _getBaseUrl() {
    return _appConfig.apiBaseUrl;
  }

  Map<String, String> _modifyHeaders(Map<String, String> headers) {
    if (!headers.containsKey('Authorization') && _authProvider.isAuthorized()) {
      var bearer = _authProvider.getBearer();
      var accessToken = _authProvider.getAccessToken();
      headers['Authorization'] = "$bearer $accessToken";
    }

    return headers;
  }
}
