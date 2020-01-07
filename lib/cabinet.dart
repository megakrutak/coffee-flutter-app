import 'package:robo_coffee_app/auth/auth_bloc.dart';
import 'package:robo_coffee_app/auth/auth_state.dart';
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
      create: (context) {
        return MenuBloc(repo: productRepo)..add(LoadMenu());
      },
      child: _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    var trans = Translator.of(context);
    var navigator = Navigator.of(context);

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
              _buildMenuItem(context, trans.trans("menu_title"), () { navigator.pushNamed("/"); }),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("cart_title"), () { navigator.pushNamed("/cart"); }),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("favorites_title"), () { navigator.pushNamed("/favorites"); }),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("history_title"), () { navigator.pushNamed("/history"); }),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("promotions_title"), () { navigator.pushNamed("/promo"); }),
              SizedBox(height: 16.0),
              _buildMenuItem(context, trans.trans("info_title"), () { navigator.pushNamed("/info"); }),
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

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      var authTitle = trans.trans("hello_title");

      if (state is AuthAuthenticated) {
        authTitle = state.profile.firstName ?? authTitle;
      }

      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(authTitle, style: theme.accentTextTheme.title),
          ),
          SizedBox(height: 16.0),
          _buildLoginButton(context, state is AuthAuthenticated),
        ],
      );
    });
  }

  Widget _buildLoginButton(BuildContext context, bool isAuthenticated) {
    var theme = Theme.of(context);
    var trans = Translator.of(context);

    var buttonTitle = trans.trans("login_button_title");
    var onClick;

    if (isAuthenticated) {
      buttonTitle = trans.trans("profile_title");
      onClick = () {
        Navigator.of(context).pushNamed('/profile');
      };
    } else {
      onClick = () {
        Navigator.of(context).pushNamed('/auth');
        /*showModalBottomSheet(
          context: context, 
          builder: (BuildContext context) {
            return AuthDialog();
          }, 
          backgroundColor: Colors.transparent,
          isScrollControlled: true
        );*/
      };
    }

    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Row(
        children: <Widget>[
          Container(),
          Text(buttonTitle, style: Theme.of(context).accentTextTheme.body1),
          Icon(
            Icons.keyboard_arrow_right,
            color: theme.accentTextTheme.title.color,
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, Function onTap) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        child: Text(title, style: theme.accentTextTheme.body1),
      ),
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
