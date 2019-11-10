import 'package:flutter/material.dart';

class RoboCoffeeLogo extends StatelessWidget {
  final Color color;

  RoboCoffeeLogo({this.color});

  @override
  Widget build(BuildContext context) {
    var logoColor = Colors.white;

    if (this.color != null) {
      logoColor = this.color;
    }

    return Row(
      children: <Widget>[
        Icon(Icons.local_cafe, color: logoColor),
        SizedBox(width: 4.0),
        Text("RoboCoffee", style: Theme.of(context).accentTextTheme.display3.copyWith(color: logoColor)),
      ],
    );
  }
}

class RoboCoffeeLogoMini extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.local_cafe, color: Colors.white),
        SizedBox(width: 4.0),
        Text("RoboCoffee")
      ],
    );
  }
}