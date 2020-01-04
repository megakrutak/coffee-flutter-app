import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robo_coffee_app/auth/auth_entity.dart';
import 'package:robo_coffee_app/auth/auth_token_storage.dart';

void main() {
  String token;
  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
        .setMockMethodCallHandler((MethodCall methodCall) async {

      if (methodCall.method == 'write') {
        token = methodCall.arguments["value"];
        return null;
      }

      if (methodCall.method == "read") {
        return token;
      }

      if (methodCall.method == "delete") {
        token = null;
        return null;
      }

      return null;
    });
  });

  group('SecureTokenStorage', () {
    test('write/read token success', () async {
      var storage = SecureTokenStorage(flutterSecureStorage);
      var token = TokenResponse("accessToken", "type", "refreshToken");
      await storage.writeToken(token);
      var tokenFromStorage = await storage.readToken();

      expect(tokenFromStorage.accessToken, "accessToken");
      expect(tokenFromStorage.type, "type");
      expect(tokenFromStorage.refreshToken, "refreshToken");
    });

    test('delete token success', () async {
      var storage = SecureTokenStorage(flutterSecureStorage);
      var token = TokenResponse("accessToken", "type", "refreshToken");
      await storage.writeToken(token);
      var tokenFromStorage = await storage.readToken();

      expect(tokenFromStorage.accessToken, "accessToken");
      expect(tokenFromStorage.type, "type");
      expect(tokenFromStorage.refreshToken, "refreshToken");

      await storage.deleteToken();
      var deletedTokenFromStorage = await storage.readToken();
      expect(deletedTokenFromStorage, null);
    });
  });
}
