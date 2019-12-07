import 'dart:io';

import 'package:flutter/services.dart';
import 'package:robo_coffee_app/cache/cache.dart';
import 'package:robo_coffee_app/product/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  setUpAll(() async {
    // Create a temporary directory.
    final directory = await Directory.systemTemp.createTemp();

    // Mock out the MethodChannel for the path_provider plugin.
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      // If you're getting the apps documents directory, return the path to the
      // temp directory on the test environment instead.
      if (methodCall.method == 'getTemporaryDirectory') {
        return directory.path;
      }
      return null;
    });
  });

  group('MemoryCacheManager', ()  {

    test('write/read success', () async {
      var product = Product(1, 1, "product1", "", "", "", List.of([]));
      var cache = MemoryCacheManager();
      await cache.write(product);
      var productFromCache = await cache.read<Product>();

      expect(Product.fromJson(productFromCache).name, "product1");
    });

    test('clear success', () async {
      var product = Product(1, 1, "product1", "", "", "", List.of([]));
      var cache = MemoryCacheManager();
      await cache.write(product);
      await cache.clear<Product>();

      var cachedProduct = await cache.read<Product>();

      expect(cachedProduct, null);
    });

    test('clear all success', () async {
      var product = Product(1, 1, "product1", "", "", "", List.of([]));
      var menu = ProductMenuItem(1, "menu1", "", 0);
      var cache = MemoryCacheManager();
      await cache.write(product);
      await cache.write(menu);
      await cache.clearAll();

      var cachedProduct = await cache.read<Product>();
      var cachedProductMenu = await cache.read<ProductMenuItem>();

      expect(cachedProduct, null);
      expect(cachedProductMenu, null);
    });

  });

  group('FileCacheManager', () {

    test('write/read success', () async {
      var product = Product(1, 1, "product1", "", "", "", List.of([]));
      var cache = FileCacheManager(localPath: "products");

      await cache.write(product);
      var productFromCache = await cache.read<Product>();

      expect(Product.fromJson(productFromCache).name, "product1");
    });

    test('clear success', () async {
      var product = Product(1, 1, "product1", "", "", "", List.of([]));
      var cache = FileCacheManager(localPath: "products");
      await cache.write(product);
      await cache.clear<Product>();

      var cachedProduct = await cache.read<Product>();

      expect(cachedProduct, null);
    });

    test('clear all success', () async {
      var product = Product(1, 1, "product1", "", "", "", List.of([]));
      var menu = ProductMenuItem(1, "menu1", "", 0);
      var cache = FileCacheManager(localPath: "products");
      await cache.write(product);
      await cache.write(menu);
      await cache.clearAll();

      var cachedProduct = await cache.read<Product>();
      var cachedProductMenu = await cache.read<ProductMenuItem>();

      expect(cachedProduct, null);
      expect(cachedProductMenu, null);
    });

  });

}