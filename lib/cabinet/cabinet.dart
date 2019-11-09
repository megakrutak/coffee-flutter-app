import 'dart:io';

import 'package:coffee_flutter_app/cart/cart.dart';
import 'package:coffee_flutter_app/lang/translator.dart';
import 'package:coffee_flutter_app/logo.dart';
import 'package:coffee_flutter_app/product/product_menu.dart';
import 'package:coffee_flutter_app/product/test.dart';
import 'package:coffee_flutter_app/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CabinetScreen extends StatefulWidget {
  CabinetScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CabinetScreenState createState() => _CabinetScreenState();
}

class _CabinetScreenState extends State<CabinetScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    MenuWidget(),
    CartWidget(),
    ProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _buildAppBarLogo(),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        elevation: 0,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.all(32.0),
            children: <Widget>[
              SizedBox(height: 32.0),
              _buildLogoItem(),
              SizedBox(height: 64.0, child: Divider()),
              _buildLoginItems(context),
              SizedBox(height: 64.0, child: Divider()),
              _buildMenuItem(context, "Меню"),
              SizedBox(height: 16.0),
              _buildMenuItem(context, "Корзина"),
              SizedBox(height: 16.0),
              _buildMenuItem(context, "Избранное"),
              SizedBox(height: 16.0),
              _buildMenuItem(context, "История заказов"),
              SizedBox(height: 16.0),
              _buildMenuItem(context, "Акции"),
              SizedBox(height: 16.0),
              _buildMenuItem(context, "Информация"),
            ],
          ),
        ),
      ),
      body: Center(
        child: MenuWidget(),
      ),
    );
  }

  Widget _buildLoginItems(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text("Привет!", style: theme.accentTextTheme.title),
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            Text("Войти", style: Theme.of(context).accentTextTheme.body1),
            Icon(Icons.keyboard_arrow_right, color: theme.accentTextTheme.title.color,)
          ],
        )
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, String title) {
    var theme = Theme.of(context);
    return Container(
      child: Text(title, style: theme.accentTextTheme.body1),
    );
  }

  Widget _buildAppBarLogo() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[RoboCoffeeLogoMini()]);
  }

  Widget _buildLogoItem() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[RoboCoffeeLogo()]);
  }
}
