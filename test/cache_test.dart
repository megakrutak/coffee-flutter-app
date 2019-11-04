import 'package:coffee_flutter_app/cache/cache.dart';
import 'package:coffee_flutter_app/product/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MemoryCacheManager', ()  {

    test('write/read success', () {
      var product = Product(1, 1, "product1", "", "", "", List.of([]));
      var cache = MemoryCacheManager();
      cache.write(product);
      var productFromCache = cache.read<Product>();

      expect(productFromCache.name, "product1");
    });

    test('clear success', () {
      var product = Product(1, 1, "product1", "", "", "", List.of([]));
      var cache = MemoryCacheManager();
      cache.write(product);
      cache.clear<Product>();

      expect(cache.read<Product>(), null);
    });

    test('clear all success', () {
      var product = Product(1, 1, "product1", "", "", "", List.of([]));
      var menu = ProductMenu(1, "menu1", "", 0);
      var cache = MemoryCacheManager();
      cache.write(product);
      cache.write(menu);
      cache.clearAll();

      expect(cache.read<Product>(), null);
      expect(cache.read<ProductMenu>(), null);
    });

  });
}