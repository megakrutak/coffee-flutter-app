import 'package:flutter/material.dart';

class RoboCoffeeLogo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.local_cafe, color: Colors.white),
        SizedBox(width: 4.0),
        Text("RoboCoffee", style: Theme.of(context).accentTextTheme.display3),
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