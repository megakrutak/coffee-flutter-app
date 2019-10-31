import 'package:coffee_flutter_app/auth_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'translator.dart';

class ProfileWidget extends StatelessWidget {

  const ProfileWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.green,
        textColor: Colors.white,
        child: Text(Translator.trans(context, "login_button_title")),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return AuthDialog();
            },
            fullscreenDialog: true
          ));
        },
      ),
    );
  }
}
