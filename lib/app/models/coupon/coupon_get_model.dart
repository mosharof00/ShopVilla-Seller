// To parse this JSON data, do
//
//     final promosGetModel = promosGetModelFromJson(jsonString);

import 'dart:convert';

PromosGetModel promosGetModelFromJson(String str) => PromosGetModel.fromJson(json.decode(str));

String promosGetModelToJson(PromosGetModel data) => json.encode(data.toJson());

class PromosGetModel {
  String? title;
  List<Promos>? data;

  PromosGetModel({
    this.title,
    this.data,
  });

  PromosGetModel copyWith({
    String? title,
    List<Promos>? data,
  }) =>
      PromosGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory PromosGetModel.fromJson(Map<String, dynamic> json) => PromosGetModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<Promos>.from(json["data"]!.map((x) => Promos.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Promos {
  int? id;
  String? code;
  String? type;
  String? amount;
  DateTime? date;
  DateTime? validity;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Promos({
    this.id,
    this.code,
    this.type,
    this.amount,
    this.date,
    this.validity,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Promos copyWith({
    int? id,
    String? code,
    String? type,
    String? amount,
    DateTime? date,
    DateTime? validity,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Promos(
        id: id ?? this.id,
        code: code ?? this.code,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        validity: validity ?? this.validity,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Promos.fromJson(Map<String, dynamic> json) => Promos(
    id: json["id"],
    code: json["code"],
    type: json["type"],
    amount: json["amount"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    validity: json["validity"] == null ? null : DateTime.parse(json["validity"]),
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "type": type,
    "amount": amount,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "validity": "${validity!.year.toString().padLeft(4, '0')}-${validity!.month.toString().padLeft(2, '0')}-${validity!.day.toString().padLeft(2, '0')}",
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
