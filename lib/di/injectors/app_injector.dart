import 'package:coffee_flutter_app/di/auth_module.dart';
import 'package:coffee_flutter_app/main.dart';
import 'package:inject/inject.dart';

import 'app_injector.inject.dart' as g;

@Injector(const [AuthModule])
abstract class AppInjector {
  @provide
  CoffeeApp get app;

  static Future<AppInjector> create(AuthModule authModule) async {
    return await g.AppInjector$Injector.create(authModule);
  }
}
