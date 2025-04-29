// To parse this JSON data, do
//
//     final supplierGetModel = supplierGetModelFromJson(jsonString);

import 'dart:convert';

SupplierGetModel supplierGetModelFromJson(String str) => SupplierGetModel.fromJson(json.decode(str));

String supplierGetModelToJson(SupplierGetModel data) => json.encode(data.toJson());

class SupplierGetModel {
  String? title;
  List<Supplier>? data;

  SupplierGetModel({
    this.title,
    this.data,
  });

  SupplierGetModel copyWith({
    String? title,
    List<Supplier>? data,
  }) =>
      SupplierGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory SupplierGetModel.fromJson(Map<String, dynamic> json) => SupplierGetModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<Supplier>.from(json["data"]!.map((x) => Supplier.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Supplier {
  int? id;
  String? supplierName;
  String? supplierPhone;
  String? supplierEmail;
  String? supplierAddress;
  dynamic supplierProfile;
  dynamic supplierCompanyName;
  int? supplierTotalAmount;
  int? supplierPaidAmount;
  int? supplierDueAmount;
  int? supplierPartialAmount;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Supplier({
    this.id,
    this.supplierName,
    this.supplierPhone,
    this.supplierEmail,
    this.supplierAddress,
    this.supplierProfile,
    this.supplierCompanyName,
    this.supplierTotalAmount,
    this.supplierPaidAmount,
    this.supplierDueAmount,
    this.supplierPartialAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Supplier copyWith({
    int? id,
    String? supplierName,
    String? supplierPhone,
    String? supplierEmail,
    String? supplierAddress,
    dynamic supplierProfile,
    dynamic supplierCompanyName,
    int? supplierTotalAmount,
    int? supplierPaidAmount,
    int? supplierDueAmount,
    int? supplierPartialAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Supplier(
        id: id ?? this.id,
        supplierName: supplierName ?? this.supplierName,
        supplierPhone: supplierPhone ?? this.supplierPhone,
        supplierEmail: supplierEmail ?? this.supplierEmail,
        supplierAddress: supplierAddress ?? this.supplierAddress,
        supplierProfile: supplierProfile ?? this.supplierProfile,
        supplierCompanyName: supplierCompanyName ?? this.supplierCompanyName,
        supplierTotalAmount: supplierTotalAmount ?? this.supplierTotalAmount,
        supplierPaidAmount: supplierPaidAmount ?? this.supplierPaidAmount,
        supplierDueAmount: supplierDueAmount ?? this.supplierDueAmount,
        supplierPartialAmount: supplierPartialAmount ?? this.supplierPartialAmount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"],
    supplierName: json["supplierName"],
    supplierPhone: json["supplierPhone"],
    supplierEmail: json["supplierEmail"],
    supplierAddress: json["supplierAddress"],
    supplierProfile: json["supplierProfile"],
    supplierCompanyName: json["supplierCompanyName"],
    supplierTotalAmount: json["supplierTotalAmount"],
    supplierPaidAmount: json["supplierPaidAmount"],
    supplierDueAmount: json["supplierDueAmount"],
    supplierPartialAmount: json["supplierPartialAmount"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplierName": supplierName,
    "supplierPhone": supplierPhone,
    "supplierEmail": supplierEmail,
    "supplierAddress": supplierAddress,
    "supplierProfile": supplierProfile,
    "supplierCompanyName": supplierCompanyName,
    "supplierTotalAmount": supplierTotalAmount,
    "supplierPaidAmount": supplierPaidAmount,
    "supplierDueAmount": supplierDueAmount,
    "supplierPartialAmount": supplierPartialAmount,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
