import 'package:bloc/bloc.dart';
import 'package:robo_coffee_app/auth/auth_event.dart';
import 'package:robo_coffee_app/auth/auth_repo.dart';
import 'package:robo_coffee_app/auth/auth_state.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({@required this.authRepository}) : assert(authRepository != null);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      var token = await authRepository.getToken();

      if (token != null) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthLoading();
      await authRepository.persistToken(event.token);
      yield AuthAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await authRepository.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}
