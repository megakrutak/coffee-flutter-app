import 'package:flutter/cupertino.dart';

class AppConfig {
  final String apiBaseUrl;
  final String apiBasicAuthUsername;
  final String apiBasicAuthPassword;

  const AppConfig(
      {@required this.apiBaseUrl,
      @required this.apiBasicAuthUsername,
      @required this.apiBasicAuthPassword});
}
