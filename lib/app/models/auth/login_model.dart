// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? status;
  List<String>? message;
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  LoginModel copyWith({
    bool? status,
    List<String>? message,
    Data? data,
  }) =>
      LoginModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
    "data": data?.toJson(),
  };
}

class Data {
  String? token;
  Admin? admin;

  Data({
    this.token,
    this.admin,
  });

  Data copyWith({
    String? token,
    Admin? admin,
  }) =>
      Data(
        token: token ?? this.token,
        admin: admin ?? this.admin,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "admin": admin?.toJson(),
  };
}

class Admin {
  int? id;
  String? name;
  String? displayName;
  String? appToken;
  String? uniqueId;
  String? email;
  String? phone;
  String? image;
  int? status;
  int? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Admin({
    this.id,
    this.name,
    this.displayName,
    this.appToken,
    this.uniqueId,
    this.email,
    this.phone,
    this.image,
    this.status,
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  Admin copyWith({
    int? id,
    String? name,
    String? displayName,
    String? appToken,
    String? uniqueId,
    String? email,
    String? phone,
    String? image,
    int? status,
    int? roleId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Admin(
        id: id ?? this.id,
        name: name ?? this.name,
        displayName: displayName ?? this.displayName,
        appToken: appToken ?? this.appToken,
        uniqueId: uniqueId ?? this.uniqueId,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        status: status ?? this.status,
        roleId: roleId ?? this.roleId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"],
    name: json["name"],
    displayName: json["display_name"],
    appToken: json["app_token"],
    uniqueId: json["unique_id"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    status: json["status"],
    roleId: json["role_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "display_name": displayName,
    "app_token": appToken,
    "unique_id": uniqueId,
    "email": email,
    "phone": phone,
    "image": image,
    "status": status,
    "role_id": roleId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
