// To parse this JSON data, do
//
//     final updateBrandModel = updateBrandModelFromJson(jsonString);

import 'dart:convert';

UpdateBrandModel updateBrandModelFromJson(String str) =>
    UpdateBrandModel.fromJson(json.decode(str));

String updateBrandModelToJson(UpdateBrandModel data) =>
    json.encode(data.toJson());

class UpdateBrandModel {
  String? message;
  Data? data;

  UpdateBrandModel({
    this.message,
    this.data,
  });

  UpdateBrandModel copyWith({
    String? message,
    Data? data,
  }) =>
      UpdateBrandModel(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory UpdateBrandModel.fromJson(Map<String, dynamic> json) =>
      UpdateBrandModel(
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
  int? id;
  String? name;
  String? slug;
  String? image;
  String? desc;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Brand({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.desc,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Brand copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    String? desc,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Brand(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        desc: desc ?? this.desc,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        desc: json["desc"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "desc": desc,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
