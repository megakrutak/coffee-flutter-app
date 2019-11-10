import 'package:robo_coffee_app/lang/translator.dart';
import 'package:robo_coffee_app/logo.dart';
import 'package:robo_coffee_app/product/menu/menu.dart';
import 'package:robo_coffee_app/product/menu/menu_bloc.dart';
import 'package:robo_coffee_app/product/menu/menu_event.dart';
import 'package:robo_coffee_app/product/product_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CabinetScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    GetIt getIt = GetIt.instance;
    var productRepo = getIt.get<ProductRepository>();

    return BlocProvider<MenuBloc>(
      builder: (context) {
        return MenuBloc(repo: productRepo)..add(LoadMenu());
      },
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    var trans = Translator.of(context);

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
              _buildMenuItem(context, trans.trans("menu_title")),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("cart_title")),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("favorites_title")),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("history_title")),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("promotions_title")),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("info_title")),
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
    var trans = Translator.of(context);

    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(trans.trans("hello_title"),
              style: theme.accentTextTheme.title),
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            Text(trans.trans("login_button_title"),
                style: Theme.of(context).accentTextTheme.body1),
            Icon(
              Icons.keyboard_arrow_right,
              color: theme.accentTextTheme.title.color,
            )
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
