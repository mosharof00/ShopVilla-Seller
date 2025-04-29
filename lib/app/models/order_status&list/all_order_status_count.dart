// To parse this JSON data, do
//
//     final adminOrderCount = adminOrderCountFromJson(jsonString);

import 'dart:convert';

AdminOrderCount adminOrderCountFromJson(String str) =>
    AdminOrderCount.fromJson(json.decode(str));

String adminOrderCountToJson(AdminOrderCount data) =>
    json.encode(data.toJson());

class AdminOrderCount {
  bool? status;
  String? message;
  AdminOrderCountData? data;

  AdminOrderCount({
    this.status,
    this.message,
    this.data,
  });

  AdminOrderCount copyWith({
    bool? status,
    String? message,
    AdminOrderCountData? data,
  }) =>
      AdminOrderCount(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory AdminOrderCount.fromJson(Map<String, dynamic> json) =>
      AdminOrderCount(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : AdminOrderCountData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class AdminOrderCountData {
  int? total;
  int? pending;
  int? confirmed;
  int? ongoing;
  int? delivered;
  int? canceled;
  int? returned;
  int? rejected;

  AdminOrderCountData({
    this.total,
    this.pending,
    this.confirmed,
    this.ongoing,
    this.delivered,
    this.canceled,
    this.returned,
    this.rejected,
  });

  AdminOrderCountData copyWith({
    int? total,
    int? pending,
    int? confirmed,
    int? ongoing,
    int? delivered,
    int? canceled,
    int? returned,
    int? rejected,
  }) =>
      AdminOrderCountData(
        total: total ?? this.total,
        pending: pending ?? this.pending,
        confirmed: confirmed ?? this.confirmed,
        ongoing: ongoing ?? this.ongoing,
        delivered: delivered ?? this.delivered,
        canceled: canceled ?? this.canceled,
        returned: returned ?? this.returned,
        rejected: rejected ?? this.rejected,
      );

  factory AdminOrderCountData.fromJson(Map<String, dynamic> json) =>
      AdminOrderCountData(
        total: json["total"],
        pending: json["pending"],
        confirmed: json["confirmed"],
        ongoing: json["ongoing"],
        delivered: json["delivered"],
        canceled: json["canceled"],
        returned: json["returned"],
        rejected: json["rejected"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "pending": pending,
        "confirmed": confirmed,
        "ongoing": ongoing,
        "delivered": delivered,
        "canceled": canceled,
        "returned": returned,
        "rejected": rejected,
      };
}
