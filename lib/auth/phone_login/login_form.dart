import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:robo_coffee_app/auth/phone_login/login_bloc.dart';
import 'package:robo_coffee_app/auth/phone_login/login_event.dart';
import 'package:robo_coffee_app/auth/phone_login/login_state.dart';
import 'package:robo_coffee_app/auth/phone_login/phone_text_field.dart';
import 'package:robo_coffee_app/auth/sms_code_timer/sms_code_timer_bloc.dart';
import 'package:robo_coffee_app/auth/sms_code_timer/sms_code_timer_event.dart';
import 'package:robo_coffee_app/auth/sms_code_timer/sms_code_timer_state.dart';
import 'package:robo_coffee_app/auth/sms_code_timer/ticker.dart';
import 'package:robo_coffee_app/lang/translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robo_coffee_app/logo.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            return _smsCodeForm(context, state.phone);
          }

          return _phoneForm(context);
        },
      ),
    );
  }

  Widget _phoneForm(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 32.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[RoboCoffeeLogo(color: theme.accentColor)]),
            SizedBox(height: 16.0),
            Text(Translator.of(context).trans("enter_phone_hint"),
                textAlign: TextAlign.center,
                style: Theme.of(context).accentTextTheme.body2),
            SizedBox(height: 16.0),
            PhoneTextField(
                onSubmit: () {
                  BlocProvider.of<LoginBloc>(context).add(SmsCodeButtonPressed(
                      phone: '+7' +
                          _phoneController.text
                              .replaceAll(RegExp(r'\-|\s'), '')));
                },
                controller: _phoneController,
                autoFocus: true),
          ],
        ),
      ),
    );
  }

  Widget _smsCodeForm(BuildContext context, String phone) {
    var trans = Translator.of(context);
    var theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Spacer(),
            Text(trans.trans("sms_code_sended_message", {'phone': phone}),
                style: theme.accentTextTheme.body1),
            PinCodeTextField(
              autofocus: true,
              hideCharacter: false,
              highlight: true,
              highlightColor: theme.accentColor,
              defaultBorderColor: theme.primaryColorLight,
              hasTextBorderColor: theme.primaryColorLight,
              maxLength: 6,
              onDone: (text) {
                BlocProvider.of<LoginBloc>(context)
                    .add(LoginButtonPressed(smsCode: text));
              },
              pinBoxWidth: 30.0,
              wrapAlignment: WrapAlignment.start,
              pinBoxDecoration:
                  ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
              pinTextStyle: TextStyle(fontSize: 20.0, color: Colors.white),
              pinTextAnimatedSwitcherTransition:
                  ProvidedPinBoxTextAnimation.scalingTransition,
              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
            ),
            Spacer(),
            Row(
              children: <Widget>[
                SmsCodeTimer(onPressed: () {
                  print("resend sms");
                }),
                Spacer(),
                FlatButton(
                  child: Text(trans.trans("change_phone_title"),
                      style: theme.accentTextTheme.body1),
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context)
                        .add(ChangePhoneButtonPressed());
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SmsCodeTimer extends StatelessWidget {
  final Function onPressed;

  SmsCodeTimer({this.onPressed});

  @override
  Widget build(BuildContext context) {
    var trans = Translator.of(context);
    var theme = Theme.of(context);

    return BlocProvider<SmsCodeTimerBloc>(builder: (context) {
      SmsCodeTimerBloc(ticker: Ticker())
      ..add(StartSmsCodeTimerEvent(duration: 60));
    }, child: BlocBuilder<SmsCodeTimerBloc, SmsCodeTimerState>(
      builder: (context, state) {
        var title = trans.trans("resend_sms_title");

        if (state is RunningSmsCodeTimerState) {
          return Text("$title (00:${state.duration})", style: theme.accentTextTheme.body1);
        }

        return FlatButton(
            child: Text("$title", style: theme.accentTextTheme.body1),
            onPressed: () {
              this.onPressed();
            });
      },
    ));
  }
}
