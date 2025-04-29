// To parse this JSON data, do
//
//     final subCategoryPostModel = subCategoryPostModelFromJson(jsonString);

import 'dart:convert';

SubCategoryPostModel subCategoryPostModelFromJson(String str) => SubCategoryPostModel.fromJson(json.decode(str));

String subCategoryPostModelToJson(SubCategoryPostModel data) => json.encode(data.toJson());

class SubCategoryPostModel {
  String? message;
  SubCategories? data;

  SubCategoryPostModel({
    this.message,
    this.data,
  });

  SubCategoryPostModel copyWith({
    String? message,
    SubCategories? data,
  }) =>
      SubCategoryPostModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SubCategoryPostModel.fromJson(Map<String, dynamic> json) => SubCategoryPostModel(
    message: json["message"],
    data: json["data"] == null ? null : SubCategories.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class SubCategories {
  Subcategory? subcategory;
  String? baseUrl;
  String? imagePath;

  SubCategories({
    this.subcategory,
    this.baseUrl,
    this.imagePath,
  });

  SubCategories copyWith({
    Subcategory? subcategory,
    String? baseUrl,
    String? imagePath,
  }) =>
      SubCategories(
        subcategory: subcategory ?? this.subcategory,
        baseUrl: baseUrl ?? this.baseUrl,
        imagePath: imagePath ?? this.imagePath,
      );

  factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
    subcategory: json["subcategory"] == null ? null : Subcategory.fromJson(json["subcategory"]),
    baseUrl: json["base_url"],
    imagePath: json["image_path"],
  );

  Map<String, dynamic> toJson() => {
    "subcategory": subcategory?.toJson(),
    "base_url": baseUrl,
    "image_path": imagePath,
  };
}

class Subcategory {
  int? categoryId;
  String? name;
  String? slug;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? image;

  Subcategory({
    this.categoryId,
    this.name,
    this.slug,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.image,
  });

  Subcategory copyWith({
    int? categoryId,
    String? name,
    String? slug,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
    String? image,
  }) =>
      Subcategory(
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        image: image ?? this.image,
      );

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    categoryId: json["category_id"],
    name: json["name"],
    slug: json["slug"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "name": name,
    "slug": slug,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "image": image,
  };
}
