// To parse this JSON data, do
//
//     final supplierDeleteModel = supplierDeleteModelFromJson(jsonString);

import 'dart:convert';

SupplierDeleteModel supplierDeleteModelFromJson(String str) => SupplierDeleteModel.fromJson(json.decode(str));

String supplierDeleteModelToJson(SupplierDeleteModel data) => json.encode(data.toJson());

class SupplierDeleteModel {
  bool? status;
  String? message;
  bool? data;

  SupplierDeleteModel({
    this.status,
    this.message,
    this.data,
  });

  SupplierDeleteModel copyWith({
    bool? status,
    String? message,
    bool? data,
  }) =>
      SupplierDeleteModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SupplierDeleteModel.fromJson(Map<String, dynamic> json) => SupplierDeleteModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
