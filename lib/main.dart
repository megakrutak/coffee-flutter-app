import 'dart:io';

import 'package:coffee_flutter_app/cart/cart.dart';
import 'package:coffee_flutter_app/catalog/catalog.dart';
import 'package:coffee_flutter_app/di/app_module.dart';
import 'package:coffee_flutter_app/lang/translator.dart';
import 'package:coffee_flutter_app/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

void main() async {
  GetIt getIt = GetIt.instance;
  registerAppModule();
  runApp(getIt.get<CoffeeApp>());
}

class CoffeeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RoboCoffee",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(title: "RoboCoffee"),
      supportedLocales: [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        Translator.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        //На ios в симуляторе баг с локалями
        if (Platform.isAndroid) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale?.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }

        return supportedLocales.first;
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    CatalogWidget(),
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
    var translator = Translator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text(translator.trans('catalog_title')),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(translator.trans('cart_title'))),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(translator.trans('profile_title'))),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
