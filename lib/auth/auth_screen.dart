import 'package:robo_coffee_app/auth/auth_bloc.dart';
import 'package:robo_coffee_app/auth/auth_repo.dart';
import 'package:robo_coffee_app/auth/phone_login/login_bloc.dart';
import 'package:robo_coffee_app/auth/phone_login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:robo_coffee_app/auth/phone_login/login_state.dart';
import 'package:robo_coffee_app/auth/sms_code_timer/sms_code_timer_bloc.dart';
import 'package:robo_coffee_app/auth/sms_code_timer/ticker.dart';
import 'package:robo_coffee_app/lang/translator.dart';
import 'package:robo_coffee_app/profile/profile_repo.dart';

class AuthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var authRepo = GetIt.instance.get<AuthRepository>();
    var profileRepo = GetIt.instance.get<ProfileRepository>();
    var translator = Translator.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(translator.trans('authorization_title')),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) {
              return LoginBloc(
                profileRepo: profileRepo,
                authRepo: authRepo, 
                authBloc: BlocProvider.of<AuthBloc>(context)
              );
            },
          ),
          BlocProvider<SmsCodeTimerBloc>(
            create: (context) {
              return SmsCodeTimerBloc(ticker: Ticker());
            }
          )
        ],
        child: LoginForm(),
      ),
    );
  }
}
