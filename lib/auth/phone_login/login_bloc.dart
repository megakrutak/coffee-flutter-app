import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:robo_coffee_app/auth/auth_bloc.dart';
import 'package:robo_coffee_app/auth/auth_entity.dart';
import 'package:robo_coffee_app/auth/auth_event.dart';
import 'package:robo_coffee_app/auth/auth_repo.dart';
import 'package:robo_coffee_app/auth/phone_login/login_event.dart';
import 'package:robo_coffee_app/auth/phone_login/login_state.dart';
import 'package:meta/meta.dart';
import 'package:robo_coffee_app/profile/profile_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ProfileRepository profileRepo;
  final AuthRepository authRepo;
  final AuthBloc authBloc;

  LoginBloc({
    @required this.authRepo,
    @required this.authBloc,
    @required this.profileRepo
  })  : assert(authRepo != null),
        assert(authBloc != null),
        assert(profileRepo != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SmsCodeButtonPressed) {
      yield LoginLoading();
      try {
        await authRepo.sendPhone(event.phone);
        await profileRepo.savePhone(event.phone);
        yield LoginInProcess(phone: event.phone);
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        TokenResponse tokenResponse = await authRepo.sendCode(event.smsCode);
        authBloc.add(LoggedIn(token: tokenResponse));
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is ChangePhoneButtonPressed) {
      yield LoginInitial();
    }
  }
}
