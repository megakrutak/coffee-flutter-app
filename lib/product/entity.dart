import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@JsonSerializable()
class ProductMenuResponse {
  @JsonKey(name: "menu")
  List<ProductMenu> menu;

  ProductMenuResponse(this.menu);

  factory ProductMenuResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductMenuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMenuResponseToJson(this);
}

@JsonSerializable()
class ProductMenu {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "photo")
  String photo;

  @JsonKey(name: "parentCategoryId")
  int parentCategoryId;

  ProductMenu(this.id, this.name, this.photo, this.parentCategoryId);

  factory ProductMenu.fromJson(Map<String, dynamic> json) =>
      _$ProductMenuFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMenuToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "categoryOfMenuId")
  int categoryOfMenuId;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "photo")
  String photo;

  @JsonKey(name: "photoOriginal")
  String photoOriginal;

  @JsonKey(name: "unit")
  String unit;

  @JsonKey(name: "modifications")
  List<ProductModification> modifications;

  Product(this.id, this.categoryOfMenuId, this.name, this.photo,
      this.photoOriginal, this.unit, this.modifications);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductModification {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "order")
  int order;

  @JsonKey(name: "price")
  int price;

  @JsonKey(name: "name")
  String name;

  ProductModification(this.id, this.order, this.price, this.name);

  factory ProductModification.fromJson(Map<String, dynamic> json) =>
      _$ProductModificationFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModificationToJson(this);
}
