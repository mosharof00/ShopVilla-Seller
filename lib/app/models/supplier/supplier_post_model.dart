// To parse this JSON data, do
//
//     final supplierPostModel = supplierPostModelFromJson(jsonString);

import 'dart:convert';

SupplierPostModel supplierPostModelFromJson(String str) => SupplierPostModel.fromJson(json.decode(str));

String supplierPostModelToJson(SupplierPostModel data) => json.encode(data.toJson());

class SupplierPostModel {
  bool? status;
  String? message;
  Data? data;

  SupplierPostModel({
    this.status,
    this.message,
    this.data,
  });

  SupplierPostModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      SupplierPostModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SupplierPostModel.fromJson(Map<String, dynamic> json) => SupplierPostModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? supplierName;
  String? supplierPhone;
  String? supplierEmail;
  String? supplierAddress;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.supplierName,
    this.supplierPhone,
    this.supplierEmail,
    this.supplierAddress,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data copyWith({
    String? supplierName,
    String? supplierPhone,
    String? supplierEmail,
    String? supplierAddress,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      Data(
        supplierName: supplierName ?? this.supplierName,
        supplierPhone: supplierPhone ?? this.supplierPhone,
        supplierEmail: supplierEmail ?? this.supplierEmail,
        supplierAddress: supplierAddress ?? this.supplierAddress,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    supplierName: json["supplierName"],
    supplierPhone: json["supplierPhone"],
    supplierEmail: json["supplierEmail"],
    supplierAddress: json["supplierAddress"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "supplierName": supplierName,
    "supplierPhone": supplierPhone,
    "supplierEmail": supplierEmail,
    "supplierAddress": supplierAddress,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
