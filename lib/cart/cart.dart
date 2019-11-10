import 'package:robo_coffee_app/lang/translator.dart';
import 'package:flutter/widgets.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translator = Translator.of(context);

    return Center(
      child: Text(translator.trans('cart_title')),
    );
  }

}