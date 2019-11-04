import 'package:coffee_flutter_app/product/entity.dart';

abstract class ProductRepository {
  Future<ProductMenu> getMenu({bool fromCache = false});

  Future<List<Product>> getProducts(
      {int categoryOfMenuId, bool fromCache = false});
}

class FakeProductRepository implements ProductRepository {
  @override
  Future<ProductMenu> getMenu({bool fromCache = false}) {
    return Future.delayed(
        Duration(seconds: 3),
        () => ProductMenu(1, "Кофе",
            "https://u24.ru/img/news/article_big_496401565261951.jpg", 0));
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
