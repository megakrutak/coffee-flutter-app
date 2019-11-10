import 'package:robo_coffee_app/product/menu/category_card.dart';
import 'package:robo_coffee_app/product/menu/menu_bloc.dart';
import 'package:robo_coffee_app/product/menu/menu_event.dart';
import 'package:robo_coffee_app/product/menu/menu_state.dart';
import 'package:robo_coffee_app/product/product_entity.dart';
import 'package:robo_coffee_app/promotion/promotions_swiper.dart';
import 'package:robo_coffee_app/ui/error.dart';
import 'package:robo_coffee_app/ui/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        if (state is MenuNotLoaded) {
          return ErrorRetry(onRetry: () {
            BlocProvider.of<MenuBloc>(context).add(LoadMenu());
          });
        }

        if (state is MenuLoaded) {
          List<ProductMenuItem> menuItems = state.menuItems;

          return SafeArea(
              child: Stack(
            children: <Widget>[
              Container(
                height: 100,
                color: Theme.of(context).primaryColor,
              ),
              ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  _buildPromoSlider(),
                  _buildMenuTiles(menuItems)
                ],
              )
            ],
          ));
        }

        return Loading();
      },
    );
  }

  Widget _buildMenuTiles(List<ProductMenuItem> menuItems) {
    return GridView.count(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: EdgeInsets.all(8.0),
      children:
          menuItems.map((category) => ProductCategoryCard(category)).toList(),
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
