import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'translator.dart';
import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget {
  @override
  AuthDialogState createState() => AuthDialogState();

  Map<String, String> map = {"sdf": "gdf"};
}

class AuthDialogState extends State<AuthDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(Translator.trans(context, "authorization_title")),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _phoneTextField(),
              RaisedButton(
                child: Text(Translator.trans(context, "send_sms_code_button_title")),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(),
              ),
              _smsCodeTextField(),
              RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text(Translator.trans(context, "login_button_title")),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _phoneTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      controller: TextEditingController(
        text: "+7 (",
      ),
      inputFormatters: [
        MaskTextInputFormatter(
          mask: '+7 (###) ###-##-##',
          filter: {"#": RegExp(r'[0-9]')},
        )
      ],
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: Translator.trans(context, "phone_input_label")),
      onChanged: (String text) {},
    );
  }

  Widget _smsCodeTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: Translator.trans(context, "sms_code_input_label")
      )
    );
  }

}
