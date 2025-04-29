// To parse this JSON data, do
//
//     final orderByCategory = orderByCategoryFromJson(jsonString);

import 'dart:convert';

OrderByCategory orderByCategoryFromJson(String str) => OrderByCategory.fromJson(json.decode(str));

String orderByCategoryToJson(OrderByCategory data) => json.encode(data.toJson());

class OrderByCategory {
  bool? status;
  String? message;
  List<OrderCategory>? data;

  OrderByCategory({
    this.status,
    this.message,
    this.data,
  });

  OrderByCategory copyWith({
    bool? status,
    String? message,
    List<OrderCategory>? data,
  }) =>
      OrderByCategory(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory OrderByCategory.fromJson(Map<String, dynamic> json) => OrderByCategory(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<OrderCategory>.from(json["data"]!.map((x) => OrderCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OrderCategory {
  int? id;
  String? categoryName;
  dynamic? percent;

  OrderCategory({
    this.id,
    this.categoryName,
    this.percent,
  });

  OrderCategory copyWith({
    int? id,
    String? categoryName,
    dynamic? percent,
  }) =>
      OrderCategory(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        percent: percent ?? this.percent,
      );

  factory OrderCategory.fromJson(Map<String, dynamic> json) => OrderCategory(
    id: json["id"],
    categoryName: json["category_name"],
    percent: json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "percent": percent,
  };
}
