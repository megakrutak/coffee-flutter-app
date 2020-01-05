import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:robo_coffee_app/auth/auth_api.dart';
import 'package:robo_coffee_app/auth/auth_provider.dart';
import 'package:robo_coffee_app/auth/auth_repo.dart';
import 'package:robo_coffee_app/auth/auth_token_storage.dart';
import 'package:robo_coffee_app/base/http.dart';
import 'package:robo_coffee_app/cache/cache.dart';
import 'package:robo_coffee_app/config/app_config.dart';
import 'package:robo_coffee_app/main.dart';
import 'package:robo_coffee_app/product/product_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:robo_coffee_app/profile/profile_api.dart';
import 'package:robo_coffee_app/profile/profile_repo.dart';

void registerAppModule() {
  GetIt getIt = GetIt.instance;

  var appConfig = AppConfig(
      apiBaseUrl: "http://robocoffee42.ru:9085",
      apiBasicAuthUsername: "client-id",
      apiBasicAuthPassword: "client-secret");

  var tokenStorage = SecureTokenStorage(FlutterSecureStorage());
  var authProvider = AppAuthProvider(tokenStorage);
  var httpClient = RestApiHttpClient(appConfig, authProvider);
  var authApi = RemoteAuthApi(appConfig, httpClient);
  var profileApi = RemoteProfileApi(httpClient);
  var profileCache = FileCacheManager(localPath: 'profile');
  var authTokenStorage = SecureTokenStorage(FlutterSecureStorage());

  getIt.registerSingleton<RestApiHttpClient>(httpClient);

  getIt.registerSingleton<AppConfig>(appConfig);

  getIt.registerSingleton<CoffeeApp>(CoffeeApp());

  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(authApi, authTokenStorage));

  getIt.registerSingleton<ProductRepository>(FakeProductRepositoryImpl());

  getIt.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(profileApi, profileCache));

}
