import 'package:coffee_flutter_app/auth/auth_entity.dart';
import 'package:flutter/widgets.dart';

class MenuWidget extends StatelessWidget {

  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      //child: Text(Translator.trans(context, "catalog_title")),
      child: Text(TokenResponse("dfgdf", "dfgdfg", "dfgdfg").toJson().toString()),
    );
  }
}