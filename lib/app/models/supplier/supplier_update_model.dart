// To parse this JSON data, do
//
//     final supplierUpdateModel = supplierUpdateModelFromJson(jsonString);

import 'dart:convert';

SupplierUpdateModel supplierUpdateModelFromJson(String str) => SupplierUpdateModel.fromJson(json.decode(str));

String supplierUpdateModelToJson(SupplierUpdateModel data) => json.encode(data.toJson());

class SupplierUpdateModel {
  bool? status;
  String? message;
  Data? data;

  SupplierUpdateModel({
    this.status,
    this.message,
    this.data,
  });

  SupplierUpdateModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      SupplierUpdateModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SupplierUpdateModel.fromJson(Map<String, dynamic> json) => SupplierUpdateModel(
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

  Data({
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

  Data copyWith({
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
      Data(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
