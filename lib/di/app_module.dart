import 'package:coffee_flutter_app/auth/api.dart';
import 'package:coffee_flutter_app/auth/auth_provider.dart';
import 'package:coffee_flutter_app/auth/repo.dart';
import 'package:coffee_flutter_app/base/http.dart';
import 'package:coffee_flutter_app/config/app_config.dart';
import 'package:coffee_flutter_app/main.dart';
import 'package:coffee_flutter_app/product/repo.dart';
import 'package:get_it/get_it.dart';

void registerAppModule() {
  GetIt getIt = GetIt.instance;

  var appConfig = AppConfig(
      apiBaseUrl: "http://localhost:8085/",
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

  getIt.registerSingleton<ProductRepository>(FakeProductRepository());

}
