import 'package:robo_coffee_app/product/product_entity.dart';

abstract class ProductRepository {
  Future<ProductMenuResponse> getMenu({bool fromCache = false});

  Future<List<Product>> getProducts(
      {int categoryOfMenuId, bool fromCache = false});
}

class FakeProductRepositoryImpl implements ProductRepository {
  @override
  Future<ProductMenuResponse> getMenu({bool fromCache = false}) {
    return Future.delayed(
        Duration(seconds: 3),
        () {
          return ProductMenuResponse(List.of([
            ProductMenuItem(1, "Кофе",
                "https://u24.ru/img/news/article_big_496401565261951.jpg", 0),
            ProductMenuItem(2, "Кофе2",
                "https://u24.ru/img/news/article_big_496401565261951.jpg", 0),
            ProductMenuItem(3, "Кофе3",
                "https://u24.ru/img/news/article_big_496401565261951.jpg", 0),
            ProductMenuItem(4, "Кофе4",
                "https://u24.ru/img/news/article_big_496401565261951.jpg", 0),
            ProductMenuItem(5, "Кофе5",
                "https://u24.ru/img/news/article_big_496401565261951.jpg", 0),
            ProductMenuItem(6, "Кофе6",
                "https://u24.ru/img/news/article_big_496401565261951.jpg", 0)
          ]));
        }
    );
  }

  @override
  Future<List<Product>> getProducts(
      {int categoryOfMenuId, bool fromCache = false}) {
    return Future.delayed(
        Duration(seconds: 3),
        () => List.of([
              Product(
                  1,
                  1,
                  "Кофе 1",
                  "https://testcf42.joinposter.com//upload/pos_cdb_7631/menu/product_1464608672_3.jpg",
                  "https://testcf42.joinposter.com//upload/pos_cdb_7631/menu/product_1464608672_3.jpg",
                  "",
                  List.of(
                      [ProductModification(3, 0, 10000, "Капучино 250 мл")]))
            ]));
  }
}
