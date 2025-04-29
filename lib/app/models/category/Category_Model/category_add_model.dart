// To parse this JSON data, do
//
//     final categoryAddModel = categoryAddModelFromJson(jsonString);

import 'dart:convert';

CategoryAddModel categoryAddModelFromJson(String str) => CategoryAddModel.fromJson(json.decode(str));

String categoryAddModelToJson(CategoryAddModel data) => json.encode(data.toJson());

class CategoryAddModel {
  String? title;
  Data? data;

  CategoryAddModel({
    this.title,
    this.data,
  });

  CategoryAddModel copyWith({
    String? title,
    Data? data,
  }) =>
      CategoryAddModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CategoryAddModel.fromJson(Map<String, dynamic> json) => CategoryAddModel(
    title: json["title"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class Data {
  String? categoryName;
  String? categoryDesc;
  String? slug;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? image;

  Data({
    this.categoryName,
    this.categoryDesc,
    this.slug,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.image,
  });

  Data copyWith({
    String? categoryName,
    String? categoryDesc,
    String? slug,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
    String? image,
  }) =>
      Data(
        categoryName: categoryName ?? this.categoryName,
        categoryDesc: categoryDesc ?? this.categoryDesc,
        slug: slug ?? this.slug,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        image: image ?? this.image,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryName: json["category_name"],
    categoryDesc: json["category_desc"],
    slug: json["slug"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "category_desc": categoryDesc,
    "slug": slug,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "image": image,
  };
}
