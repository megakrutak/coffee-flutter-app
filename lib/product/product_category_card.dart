import 'package:coffee_flutter_app/product/product_entity.dart';
import 'package:coffee_flutter_app/ui/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCategoryCard extends StatelessWidget {
  final ProductMenu category;

  ProductCategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: PNetworkImage(category.photo, fit: BoxFit.cover),
        ),
        Column(
          children: <Widget>[
            Spacer(),
            Container(
              height: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  color: Colors.black.withOpacity(0.3),
              ),
            )
          ],
        ),
        Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(category.name, style: theme.accentTextTheme.subhead)),
      ],
    );
  }
}
