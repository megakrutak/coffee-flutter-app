import 'package:coffee_flutter_app/auth/auth_entity.dart';
import 'package:coffee_flutter_app/product/product_category_card.dart';
import 'package:coffee_flutter_app/product/product_entity.dart';
import 'package:coffee_flutter_app/product/test.dart';
import 'package:coffee_flutter_app/promotion/promotion_card.dart';
import 'package:coffee_flutter_app/promotion/promotions_swiper.dart';
import 'package:coffee_flutter_app/ui/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: <Widget>[
          Container(
            height: 100,
            color: Colors.green,
          ),
          ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              _buildPromoSlider(),
              _buildMenuTiles()
            ],
          )
        ],)
    );
  }

  Widget _buildMenuTiles() {
    List<ProductMenu> menuItems = [
      ProductMenu(
          1,
          "Кофе",
          "https://upload.wikimedia.org/wikipedia/commons/4/45/A_small_cup_of_coffee.JPG",
          0),
      ProductMenu(2, "Другие напитки",
          "https://www.sq.com.ua/img/news/2019/07/21/voda.jpg", 0),
      ProductMenu(
          3,
          "Закуски",
          "http://hungryboyfriend.ru/wp-content/uploads/2016/06/domashnij-burger.jpg",
          0),
      ProductMenu(
          4,
          "Десерты",
          "https://smachno.ua/wp-content/uploads/2017/05/11/pexels-photo-1132558.jpeg",
          0),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: EdgeInsets.all(8.0),
      children: menuItems.map((category) => ProductCategoryCard(category)).toList(),
    );
  }

  Widget _buildPromoSlider() {
    return Container(
      padding: EdgeInsets.all(0),
      height: 200.0,
      child: PromotionsSwiper(),
    );
  }
}
