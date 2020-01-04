import 'package:robo_coffee_app/auth/auth_bloc.dart';
import 'package:robo_coffee_app/auth/auth_dialog.dart';
import 'package:robo_coffee_app/auth/auth_state.dart';
import 'package:robo_coffee_app/lang/translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWidget extends StatelessWidget {

  const ProfileWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return _profileWidget(context);
        }

        return _loginWidget(context);
      },
    );
  }

  Widget _profileWidget(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.redAccent,
        textColor: Colors.white,
        child: Text(Translator.of(context).trans("logout_button_title")),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return AuthScreen();
              },
              fullscreenDialog: true
          ));
        },
      ),
    );
  }

  Widget _loginWidget(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.green,
        textColor: Colors.white,
        child: Text(Translator.of(context).trans("login_button_title")),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return AuthScreen();
              },
              fullscreenDialog: true
          ));
        },
      ),
    );
  }
}
