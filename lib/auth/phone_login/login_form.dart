import 'package:coffee_flutter_app/auth/phone_login/login_bloc.dart';
import 'package:coffee_flutter_app/auth/phone_login/login_event.dart';
import 'package:coffee_flutter_app/auth/phone_login/login_state.dart';
import 'package:coffee_flutter_app/lang/translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _phoneController = TextEditingController(
    text: "+7 (",
  );

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

          return _phoneForm(_trans);
        },
      ),
    );
  }

  Widget _phoneForm(Translator trans) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.number,
              controller: _phoneController,
              inputFormatters: [
                MaskTextInputFormatter(
                  mask: '+7 (###) ###-##-##',
                  filter: {"#": RegExp(r'[0-9]')},
                )
              ],
              decoration: InputDecoration(
                  labelText: Translator.of(context).trans("phone_input_label")),
              onChanged: (String text) {},
            ),
            FlatButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: Text(
                  trans.trans("send_sms_code_button_title"),
                ),
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(
                    SmsCodeButtonPressed(phone: _phoneController.text),
                  );
                }),
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
