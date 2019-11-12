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
            ProductMenuItem(2, "Другие напитки",
                "https://nversia.ru/imgs/thumbs_news/1562653533_1147681669_720-480.jpg", 0),
            ProductMenuItem(3, "Закуски",
                "https://gotovim-doma.ru/images/recipe/4/55/4553ffb0b2312eb327c1437769bb1e6d_l.jpg", 0),
            ProductMenuItem(4, "Выпечка",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRs4QjdBSsem5z--xbFmIgs9GWAEdzWogm3w6NT-7oYBTmMlr0_", 0),
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
