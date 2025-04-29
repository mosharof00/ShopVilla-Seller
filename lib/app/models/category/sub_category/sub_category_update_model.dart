// To parse this JSON data, do
//
//     final subCategoryUpdateModel = subCategoryUpdateModelFromJson(jsonString);

import 'dart:convert';

SubCategoryUpdateModel subCategoryUpdateModelFromJson(String str) => SubCategoryUpdateModel.fromJson(json.decode(str));

String subCategoryUpdateModelToJson(SubCategoryUpdateModel data) => json.encode(data.toJson());

class SubCategoryUpdateModel {
  String? message;
  Data? data;

  SubCategoryUpdateModel({
    this.message,
    this.data,
  });

  SubCategoryUpdateModel copyWith({
    String? message,
    Data? data,
  }) =>
      SubCategoryUpdateModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SubCategoryUpdateModel.fromJson(Map<String, dynamic> json) => SubCategoryUpdateModel(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Category? category;
  String? baseUrl;
  String? imagePath;

  Data({
    this.category,
    this.baseUrl,
    this.imagePath,
  });

  Data copyWith({
    Category? category,
    String? baseUrl,
    String? imagePath,
  }) =>
      Data(
        category: category ?? this.category,
        baseUrl: baseUrl ?? this.baseUrl,
        imagePath: imagePath ?? this.imagePath,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    baseUrl: json["base_url"],
    imagePath: json["image_path"],
  );

  Map<String, dynamic> toJson() => {
    "category": category?.toJson(),
    "base_url": baseUrl,
    "image_path": imagePath,
  };
}

class Category {
  int? id;
  int? categoryId;
  String? name;
  String? slug;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.categoryId,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  Category copyWith({
    int? id,
    int? categoryId,
    String? name,
    String? slug,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Category(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "slug": slug,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
