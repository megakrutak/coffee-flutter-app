import 'dart:convert';
import 'package:robo_coffee_app/auth/auth_provider.dart';
import 'package:robo_coffee_app/base/http_error_handler.dart';
import 'package:robo_coffee_app/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:http_logger/http_logger.dart';
import 'package:http_middleware/http_with_middleware.dart';

class RestApiHttpClient {

  HttpWithMiddleware _httpClient = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
    HttpErrorHandler()
  ]);

  AppConfig _appConfig;
  AuthProvider _authProvider;

  RestApiHttpClient(this._appConfig, this._authProvider);

  Future<http.Response> delete(url, {Map<String, String> headers}) {
    return _httpClient.delete(_getBaseUrl() + url, headers: _modifyHeaders(headers));
  }

  Future<http.Response> get(url, {Map<String, String> headers}) {
    return _httpClient.get(_getBaseUrl() + url, headers: _modifyHeaders(headers));
  }

  Future<http.Response> head(url, {Map<String, String> headers}) {
    return _httpClient.head(_getBaseUrl() + url, headers: _modifyHeaders(headers));
  }

  Future<http.Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return _httpClient.patch(_getBaseUrl() + url,
        headers: _modifyHeaders(headers), body: body, encoding: encoding);
  }

  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return _httpClient.post(_getBaseUrl() + url,
        headers: _modifyHeaders(headers), body: body, encoding: encoding);
  }

  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return _httpClient.put(_getBaseUrl() + url,
        headers: _modifyHeaders(headers), body: body, encoding: encoding);
  }

  String _getBaseUrl() {
    return _appConfig.apiBaseUrl;
  }

  Map<String, String> _modifyHeaders(Map<String, String> headers) {
    if (!headers.containsKey('Content-Type')) {
      headers['Content-Type'] = 'application/json';
    }

    //TODO: сделать обертку json строки для map

    if (!headers.containsKey('Authorization') && _authProvider.isAuthorized()) {
      var bearer = _authProvider.getBearer();
      var accessToken = _authProvider.getAccessToken();
      headers['Authorization'] = "$bearer $accessToken";
    }

    return headers;
  }
}
