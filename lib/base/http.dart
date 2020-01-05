import 'dart:convert';
import 'package:robo_coffee_app/auth/auth_provider.dart';
import 'package:robo_coffee_app/base/http_error_handler.dart';
import 'package:robo_coffee_app/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:http_logger/http_logger.dart';
import 'package:http_middleware/http_with_middleware.dart';

class RestApiHttpClient {
  HttpWithMiddleware _httpClient = HttpWithMiddleware.build(
      middlewares: [HttpLogger(logLevel: LogLevel.BODY), HttpErrorHandler()]);

  AppConfig _appConfig;
  AuthProvider _authProvider;

  RestApiHttpClient(this._appConfig, this._authProvider);

  Future<http.Response> delete(url, {Map<String, String> headers}) async {
    var modifiedHeaders = await _modifyHeaders(headers);

    return _httpClient.delete(_getBaseUrl() + url, headers: modifiedHeaders);
  }

  Future<http.Response> get(url, {Map<String, String> headers}) async {
    var modifiedHeaders = await _modifyHeaders(headers);

    return _httpClient.get(_getBaseUrl() + url, headers: modifiedHeaders);
  }

  Future<http.Response> head(url, {Map<String, String> headers}) async {
    var modifiedHeaders = await _modifyHeaders(headers);

    return _httpClient.head(_getBaseUrl() + url, headers: modifiedHeaders);
  }

  Future<http.Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    var modifiedHeaders = await _modifyHeaders(headers);

    return _httpClient.patch(_getBaseUrl() + url,
        headers: modifiedHeaders, body: body, encoding: encoding);
  }

  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    var modifiedHeaders = await _modifyHeaders(headers);

    return _httpClient.post(_getBaseUrl() + url,
        headers: modifiedHeaders, body: body, encoding: encoding);
  }

  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    var modifiedHeaders = await _modifyHeaders(headers);

    return _httpClient.put(_getBaseUrl() + url,
        headers: modifiedHeaders, body: body, encoding: encoding);
  }

  String _getBaseUrl() {
    return _appConfig.apiBaseUrl;
  }

  Future<Map<String, String>> _modifyHeaders(Map<String, String> headers) async {
    headers ??= Map<String, String>();

    if (!headers.containsKey('Content-Type')) {
      headers['Content-Type'] = 'application/json';
    }

    //TODO: сделать обертку json строки для map

    var isAuthorized = await _authProvider.isAuthorized();

    if (!headers.containsKey('Authorization') && isAuthorized) {
      var bearer = await _authProvider.getBearer();
      var accessToken = await _authProvider.getAccessToken();
      headers['Authorization'] = "$bearer $accessToken";
    }

    return headers;
  }
}
