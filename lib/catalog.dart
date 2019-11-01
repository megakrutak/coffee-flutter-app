
import 'package:coffee_flutter_app/auth/data.dart';
import 'package:coffee_flutter_app/translator.dart';
import 'package:flutter/widgets.dart';

class CatalogWidget extends StatelessWidget {

  const CatalogWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      //child: Text(Translator.trans(context, "catalog_title")),
      child: Text(TokenResponse("dfgdf", "dfgdfg", "dfgdfg").toJson().toString()),
    );
  }
}