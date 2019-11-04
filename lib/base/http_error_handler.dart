import 'dart:convert';
import 'dart:io';

import 'package:coffee_flutter_app/base/exception.dart';
import 'package:http_middleware/http_middleware.dart';

class HttpErrorHandler implements MiddlewareContract {
  @override
  void interceptRequest({RequestData data}) {}

  @override
  void interceptResponse({ResponseData data}) {
    var errorCode = AppException.unknown;
    var errorMessage = '';

    if (data.statusCode >= HttpStatus.badRequest) {
      if (data.headers.containsKey('Content-Type')) {
        if (data.headers['Content-Type'].contains('application/json')) {
          var mappedJson = json.decode(data.body);
          errorCode = mappedJson['error'] ?? AppException.unknown;
          errorMessage = mappedJson['error_description'] ?? '';
        }
      }

      throw AppException(errorCode, errorMessage);
    }
  }
}