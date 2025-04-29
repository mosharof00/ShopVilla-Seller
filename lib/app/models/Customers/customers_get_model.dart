// To parse this JSON data, do
//
//     final customersGetModel = customersGetModelFromJson(jsonString);

import 'dart:convert';

CustomersGetModel customersGetModelFromJson(String str) => CustomersGetModel.fromJson(json.decode(str));

String customersGetModelToJson(CustomersGetModel data) => json.encode(data.toJson());

class CustomersGetModel {
  String? title;
  List<Customers>? data;

  CustomersGetModel({
    this.title,
    this.data,
  });

  CustomersGetModel copyWith({
    String? title,
    List<Customers>? data,
  }) =>
      CustomersGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CustomersGetModel.fromJson(Map<String, dynamic> json) => CustomersGetModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<Customers>.from(json["data"]!.map((x) => Customers.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Customers {
  int? id;
  String? name;
  String? gender;
  String? birthday;
  dynamic country;
  dynamic phone;
  dynamic deviceToken;
  String? image;
  String? email;
  String? appToken;
  dynamic emailVerifiedAt;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Customers({
    this.id,
    this.name,
    this.gender,
    this.birthday,
    this.country,
    this.phone,
    this.deviceToken,
    this.image,
    this.email,
    this.appToken,
    this.emailVerifiedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Customers copyWith({
    int? id,
    String? name,
    String? gender,
    String? birthday,
    dynamic country,
    dynamic phone,
    dynamic deviceToken,
    String? image,
    String? email,
    String? appToken,
    dynamic emailVerifiedAt,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Customers(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        country: country ?? this.country,
        phone: phone ?? this.phone,
        deviceToken: deviceToken ?? this.deviceToken,
        image: image ?? this.image,
        email: email ?? this.email,
        appToken: appToken ?? this.appToken,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    birthday: json["birthday"],
    country: json["country"],
    phone: json["phone"],
    deviceToken: json["device_token"],
    image: json["image"],
    email: json["email"],
    appToken: json["app_token"],
    emailVerifiedAt: json["email_verified_at"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender": gender,
    "birthday": birthday,
    "country": country,
    "phone": phone,
    "device_token": deviceToken,
    "image": image,
    "email": email,
    "app_token": appToken,
    "email_verified_at": emailVerifiedAt,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
