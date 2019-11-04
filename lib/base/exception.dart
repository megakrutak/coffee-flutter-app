
class AppException implements Exception {

  static const String unauthorized = 'unauthorized';
  static const String unknown = 'unknown';
  final errorCode;
  final message;

  AppException([this.errorCode, this.message]);

  String toString() {
    if (errorCode == null) return "Exception";
    return "Exception: $errorCode - $message";
  }

}