import 'package:coffee_flutter_app/logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Row(
          children: <Widget>[
            Spacer(),
            RoboCoffeeLogo(),
            Spacer()
          ],
        ),
      ),
    );
  }
}