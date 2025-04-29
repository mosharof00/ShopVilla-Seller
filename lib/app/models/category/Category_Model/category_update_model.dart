// To parse this JSON data, do
//
//     final categoryUpdateModel = categoryUpdateModelFromJson(jsonString);

import 'dart:convert';

CategoryUpdateModel categoryUpdateModelFromJson(String str) => CategoryUpdateModel.fromJson(json.decode(str));

String categoryUpdateModelToJson(CategoryUpdateModel data) => json.encode(data.toJson());

class CategoryUpdateModel {
  String? message;
  Data? data;

  CategoryUpdateModel({
    this.message,
    this.data,
  });

  CategoryUpdateModel copyWith({
    String? message,
    Data? data,
  }) =>
      CategoryUpdateModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CategoryUpdateModel.fromJson(Map<String, dynamic> json) => CategoryUpdateModel(
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
  String? categoryName;
  String? slug;
  String? type;
  String? image;
  bool? status;
  String? categoryDesc;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.categoryName,
    this.slug,
    this.type,
    this.image,
    this.status,
    this.categoryDesc,
    this.createdAt,
    this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? categoryName,
    String? slug,
    String? type,
    String? image,
    bool? status,
    String? categoryDesc,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Category(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        slug: slug ?? this.slug,
        type: type ?? this.type,
        image: image ?? this.image,
        status: status ?? this.status,
        categoryDesc: categoryDesc ?? this.categoryDesc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryName: json["category_name"],
    slug: json["slug"],
    type: json["type"],
    image: json["image"],
    status: json["status"],
    categoryDesc: json["category_desc"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "slug": slug,
    "type": type,
    "image": image,
    "status": status,
    "category_desc": categoryDesc,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
