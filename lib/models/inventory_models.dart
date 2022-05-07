import 'dart:convert';

// CATEGORY MODEL

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    required this.title,
    this.description,
    this.parent_id,
    required this.id,
  });

  String title;
  String? description;
  int? parent_id;
  int id;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        title: json["title"],
        description: json["description"],
        parent_id: json["parent_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "parent_id": parent_id,
        "id": id,
      };
}

// ITEM MODEL

List<ItemModel> itemModelFromJson(String str) =>
    List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromJson(x)));

String itemModelToJson(List<ItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemModel {
  ItemModel({
    required this.title,
    this.description,
    this.price,
    this.link,
    this.category_id,
    required this.id,
  });

  String title;
  String? description;
  double? price;
  String? link;
  int? category_id;
  int id;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        link: json["link"],
        category_id: json["category_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price,
        "link": link,
        "category_id": category_id,
        "id": id,
      };
}
