
import 'package:coffee_flutter_app/ui/network_image.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class EcommerceOnePage extends StatelessWidget {
  static final String path = "lib/src/pages/ecommerce/ecommerce1.dart";
  final List<String> categories = ['DarazMall', 'Flash Sales', 'Collection', 'Vouchers', 'Categories'];
  final List<String> images = [
    "https://upload.wikimedia.org/wikipedia/commons/4/45/A_small_cup_of_coffee.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/4/45/A_small_cup_of_coffee.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/4/45/A_small_cup_of_coffee.JPG"
  ];
  final List<String> flashSaleImages = [
    "https://upload.wikimedia.org/wikipedia/commons/4/45/A_small_cup_of_coffee.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/4/45/A_small_cup_of_coffee.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/4/45/A_small_cup_of_coffee.JPG"
  ];

  Widget _buildListView(BuildContext context, index) {

    var theme = Theme.of(context);
    if(index==0) return _buildSlider(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                PNetworkImage(images[index%images.length]),
                SizedBox(height: 10.0,),
                Text('Top Quality fashion item', softWrap: true,),
                SizedBox(height: 10.0,),
                Text('Rs.1,254', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),)
              ],
            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              children: <Widget>[
                PNetworkImage(images[(index - 1) %images.length]),
                SizedBox(height: 10.0,),
                Text('Top Quality fashion item', softWrap: true,),
                SizedBox(height: 10.0,),
                Text('Rs.1,254', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {

    var theme = Theme.of(context);

    List<String> promoImages = [
      "https://cdn.24.co.za/files/Cms/General/d/8470/840a8cce78b94906b08a632c8cbc9a67.png",
      "https://cdn.24.co.za/files/Cms/General/d/8470/840a8cce78b94906b08a632c8cbc9a67.png",
      "https://cdn.24.co.za/files/Cms/General/d/8470/840a8cce78b94906b08a632c8cbc9a67.png",
    ];

    return Container(
      height: 120.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: DiagonalPathClipperOne(),
            child: Container(
              height: 110,
              color: Colors.deepPurple,
            ),
          ),
          Container(
            child: Swiper(
              autoplay: true,
              autoplayDelay: 2000,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: PNetworkImage(promoImages[index], fit: BoxFit.cover),
                  ),
                );
              },
              itemCount: 3,
              pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      activeColor: theme.accentTextTheme.title.color,
                      size: 6,
                      activeSize: 6,
                      color: theme.accentTextTheme.title.color.withOpacity(0.5)
                  ),
                  alignment: Alignment.bottomRight
              ),
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: ListView.builder(
            itemBuilder: _buildListView,
            itemCount: 10,
          )
    );
  }
}