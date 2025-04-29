// To parse this JSON data, do
//
//     final courierGetModel = courierGetModelFromJson(jsonString);

import 'dart:convert';

CourierGetModel courierGetModelFromJson(String str) => CourierGetModel.fromJson(json.decode(str));

String courierGetModelToJson(CourierGetModel data) => json.encode(data.toJson());

class CourierGetModel {
  String? title;
  List<dynamic>? data;

  CourierGetModel({
    this.title,
    this.data,
  });

  CourierGetModel copyWith({
    String? title,
    List<dynamic>? data,
  }) =>
      CourierGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CourierGetModel.fromJson(Map<String, dynamic> json) => CourierGetModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
