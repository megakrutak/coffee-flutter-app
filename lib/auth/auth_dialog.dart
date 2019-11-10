import 'package:robo_coffee_app/auth/auth_bloc.dart';
import 'package:robo_coffee_app/auth/auth_repo.dart';
import 'package:robo_coffee_app/auth/phone_login/login_bloc.dart';
import 'package:robo_coffee_app/auth/phone_login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:robo_coffee_app/ui/fullscreen_dialog.dart';

class AuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authRepo = GetIt.instance.get<AuthRepository>();

    return FullScreenDialog(
      color: Colors.deepPurple,
      child: BlocProvider<LoginBloc>(
        builder: (context) {
          return LoginBloc(
              authRepo: authRepo, authBloc: BlocProvider.of<AuthBloc>(context));
        },
        child: LoginForm(),
      ),
    );
  }
}
