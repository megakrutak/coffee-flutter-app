import 'package:bloc/bloc.dart';
import 'package:robo_coffee_app/auth/auth_event.dart';
import 'package:robo_coffee_app/auth/auth_repo.dart';
import 'package:robo_coffee_app/auth/auth_state.dart';
import 'package:meta/meta.dart';
import 'package:robo_coffee_app/profile/profile_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;
  final ProfileRepository profileRepo;

  AuthBloc({@required this.authRepo, @required this.profileRepo}) : assert(authRepo != null && profileRepo != null);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      var token = await authRepo.getToken();
      var profile = await profileRepo.getProfile();

      if (token != null) {
        yield AuthAuthenticated(profile: profile);
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthLoading();
      await authRepo.persistToken(event.token);
      var profile = await profileRepo.getProfile(fromCache: true);
      yield AuthAuthenticated(profile: profile);
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await authRepo.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}
