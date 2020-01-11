import 'package:flutter/material.dart';


var appTheme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: Colors.green,
  primaryColorDark: Colors.green[600],
  primaryColorLight: Colors.green[300],
  accentColor: Colors.blue,

  // Define the default font family.
  fontFamily: 'Montserrat',

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 24.0, fontStyle: FontStyle.normal),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
    subtitle: TextStyle(fontSize: 16.0)
  ),

  accentTextTheme: TextTheme(
    subhead: TextStyle(fontSize: 18.0, color: Colors.white),
    display3: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
    title: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    body1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white),
    body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white)
  ),

  primaryTextTheme: TextTheme()

);