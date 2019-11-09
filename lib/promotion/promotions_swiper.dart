import 'package:coffee_flutter_app/ui/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PromotionsSwiper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    List<String> promoImages = [
      "https://cdn.24.co.za/files/Cms/General/d/8470/840a8cce78b94906b08a632c8cbc9a67.png",
      "https://cdn.24.co.za/files/Cms/General/d/8470/840a8cce78b94906b08a632c8cbc9a67.png",
      "https://cdn.24.co.za/files/Cms/General/d/8470/840a8cce78b94906b08a632c8cbc9a67.png",
    ];

    return Container(
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: PNetworkImage(promoImages[index], fit: BoxFit.cover),
            ),
          );
        },
        autoplay: true,
        autoplayDelay: 2000,
        itemCount: promoImages.length,
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
    );
  }


}