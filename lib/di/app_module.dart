import 'package:robo_coffee_app/auth/auth_api.dart';
import 'package:robo_coffee_app/auth/auth_provider.dart';
import 'package:robo_coffee_app/auth/auth_repo.dart';
import 'package:robo_coffee_app/base/http.dart';
import 'package:robo_coffee_app/config/app_config.dart';
import 'package:robo_coffee_app/main.dart';
import 'package:robo_coffee_app/product/product_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:robo_coffee_app/profile/profile_repo.dart';

void registerAppModule() {
  GetIt getIt = GetIt.instance;

  var appConfig = AppConfig(
      apiBaseUrl: "http://192.168.1.101:8085",
      apiBasicAuthUsername: "client-id",
      apiBasicAuthPassword: "client-secret");

  //FIXME: убрать это дерьмо
  var authProvider = AppAuthProvider(null, null);
  var httpClient = RestApiHttpClient(appConfig, authProvider);
  var authApi = RemoteAuthApi(appConfig, httpClient);

  getIt.registerSingleton<RestApiHttpClient>(httpClient);

  getIt.registerSingleton<AppConfig>(appConfig);

  getIt.registerSingleton<CoffeeApp>(CoffeeApp());

  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(authApi));

  getIt.registerSingleton<ProductRepository>(FakeProductRepositoryImpl());

  getIt.registerSingleton<ProfileRepository>(FakeProfileRepositoryImpl());

}
