import 'package:coffee_flutter_app/auth/repo.dart';
import 'package:inject/inject.dart';

@module
class AuthModule {

  @provide
  AuthRepository authRepository() => MockAuthRepository();
}