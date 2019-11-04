import 'package:coffee_flutter_app/cart/cart.dart';
import 'package:coffee_flutter_app/lang/translator.dart';
import 'package:coffee_flutter_app/product/menu.dart';
import 'package:coffee_flutter_app/profile/profile.dart';
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