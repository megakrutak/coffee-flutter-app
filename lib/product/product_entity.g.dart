// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductMenuResponse _$ProductMenuResponseFromJson(Map<String, dynamic> json) {
  return ProductMenuResponse((json['menu'] as List)
      ?.map((e) =>
          e == null ? null : ProductMenu.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$ProductMenuResponseToJson(
        ProductMenuResponse instance) =>
    <String, dynamic>{'menu': instance.menu};

ProductMenu _$ProductMenuFromJson(Map<String, dynamic> json) {
  return ProductMenu(json['id'] as int, json['name'] as String,
      json['photo'] as String, json['parentCategoryId'] as int);
}

Map<String, dynamic> _$ProductMenuToJson(ProductMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'parentCategoryId': instance.parentCategoryId
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
      json['id'] as int,
      json['categoryOfMenuId'] as int,
      json['name'] as String,
      json['photo'] as String,
      json['photoOriginal'] as String,
      json['unit'] as String,
      (json['modifications'] as List)
          ?.map((e) => e == null
              ? null
              : ProductModification.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'categoryOfMenuId': instance.categoryOfMenuId,
      'name': instance.name,
      'photo': instance.photo,
      'photoOriginal': instance.photoOriginal,
      'unit': instance.unit,
      'modifications': instance.modifications
    };

ProductModification _$ProductModificationFromJson(Map<String, dynamic> json) {
  return ProductModification(json['id'] as int, json['order'] as int,
      json['price'] as int, json['name'] as String);
}

Map<String, dynamic> _$ProductModificationToJson(
        ProductModification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'price': instance.price,
      'name': instance.name
    };
