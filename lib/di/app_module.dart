import 'package:coffee_flutter_app/auth/repo.dart';
import 'package:coffee_flutter_app/main.dart';
import 'package:get_it/get_it.dart';

void registerAppModule() {
  GetIt getIt = GetIt.instance;

  getIt.registerSingleton<CoffeeApp>(new CoffeeApp());

  getIt.registerSingleton<AuthRepository>(MockedAuthRepository());
}
