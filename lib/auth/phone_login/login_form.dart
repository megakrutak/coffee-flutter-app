import 'package:robo_coffee_app/auth/phone_login/login_bloc.dart';
import 'package:robo_coffee_app/auth/phone_login/login_event.dart';
import 'package:robo_coffee_app/auth/phone_login/login_state.dart';
import 'package:robo_coffee_app/auth/phone_login/phone_text_field.dart';
import 'package:robo_coffee_app/lang/translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:robo_coffee_app/logo.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _phoneController = TextEditingController();
  var _smsCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _trans = Translator.of(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state is LoginSuccess) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoginInProcess) {
            return _smsCodeForm(_trans);
          }

          return _phoneForm(context);
        },
      ),
    );
  }

  Widget _phoneForm(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 32.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[RoboCoffeeLogo()]),
            SizedBox(height: 16.0),
            Text(Translator.of(context).trans("enter_phone_hint"), style: Theme.of(context).accentTextTheme.body2),
            SizedBox(height: 16.0),
            PhoneTextField(onSubmit: () {

            }, controller: _phoneController, autoFocus: true),
          ],
        ),
      ),
    );
  }

  Widget _smsCodeForm(Translator trans) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            /*PinCodeTextField(
              autofocus: true,
              hideCharacter: false,
              highlight: true,
              highlightColor: Colors.blue,
              defaultBorderColor: Colors.black,
              hasTextBorderColor: Colors.green,
              maxLength: 4,
              onDone: (text){
                print("DONE $text");
              },
              pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
              wrapAlignment: WrapAlignment.start,
              pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
              pinTextStyle: TextStyle(fontSize: 30.0),
              pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
            )*/
            TextField(
                autofocus: true,
                controller: _smsCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText:
                        Translator.of(context).trans("sms_code_input_label"))),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text(trans.trans("login_button_title")),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(
                  LoginButtonPressed(smsCode: _smsCodeController.text),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
