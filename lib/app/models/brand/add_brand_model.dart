// To parse this JSON data, do
//
//     final addBrandModel = addBrandModelFromJson(jsonString);

import 'dart:convert';

AddBrandModel addBrandModelFromJson(String str) =>
    AddBrandModel.fromJson(json.decode(str));

String addBrandModelToJson(AddBrandModel data) => json.encode(data.toJson());

class AddBrandModel {
  String? message;
  Data? data;

  AddBrandModel({
    this.message,
    this.data,
  });

  AddBrandModel copyWith({
    String? message,
    Data? data,
  }) =>
      AddBrandModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory AddBrandModel.fromJson(Map<String, dynamic> json) => AddBrandModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Brand? brand;
  String? baseUrl;
  String? imagePath;

  Data({
    this.brand,
    this.baseUrl,
    this.imagePath,
  });

  Data copyWith({
    Brand? brand,
    String? baseUrl,
    String? imagePath,
  }) =>
      Data(
        brand: brand ?? this.brand,
        baseUrl: baseUrl ?? this.baseUrl,
        imagePath: imagePath ?? this.imagePath,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        baseUrl: json["base_url"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "brand": brand?.toJson(),
        "base_url": baseUrl,
        "image_path": imagePath,
      };
}

class Brand {
  String? name;
  String? desc;
  String? slug;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? image;

  Brand({
    this.name,
    this.desc,
    this.slug,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.image,
  });

  Brand copyWith({
    String? name,
    String? desc,
    String? slug,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
    String? image,
  }) =>
      Brand(
        name: name ?? this.name,
        desc: desc ?? this.desc,
        slug: slug ?? this.slug,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        image: image ?? this.image,
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        name: json["name"],
        desc: json["desc"],
        slug: json["slug"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "slug": slug,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "image": image,
      };
}
