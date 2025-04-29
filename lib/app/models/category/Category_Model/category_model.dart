// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String? title;
  List<Categories>? data;

  CategoryModel({
    this.title,
    this.data,
  });

  CategoryModel copyWith({
    String? title,
    List<Categories>? data,
  }) =>
      CategoryModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    title: json["title"],
    data: json["data"] == null
        ? []
        : List<Categories>.from(
        json["data"]!.map((x) => Categories.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Categories {
  int? id;
  String? categoryName;
  String? slug;
  String? image;
  bool? status;
  String? categoryDesc;
  dynamic createdAt;
  DateTime? updatedAt;

  Categories({
    this.id,
    this.categoryName,
    this.slug,
    this.image,
    this.status,
    this.categoryDesc,
    this.createdAt,
    this.updatedAt,
  });

  Categories copyWith({
    int? id,
    String? categoryName,
    String? slug,
    String? image,
    bool? status,
    String? categoryDesc,
    dynamic createdAt,
    DateTime? updatedAt,
  }) =>
      Categories(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        status: status ?? this.status,
        categoryDesc: categoryDesc ?? this.categoryDesc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["id"],
    categoryName: json["category_name"],
    slug: json["slug"],
    image: json["image"],
    status: json["status"],
    categoryDesc: json["category_desc"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "slug": slug,
    "image": image,
    "status": status,
    "category_desc": categoryDesc,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
  };
}
