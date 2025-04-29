// To parse this JSON data, do
//
//     final profileGetModel = profileGetModelFromJson(jsonString);

import 'dart:convert';

ProfileGetModel profileGetModelFromJson(String str) => ProfileGetModel.fromJson(json.decode(str));

String profileGetModelToJson(ProfileGetModel data) => json.encode(data.toJson());

class ProfileGetModel {
  String? title;
  ProfileDetails? data;

  ProfileGetModel({
    this.title,
    this.data,
  });

  ProfileGetModel copyWith({
    String? title,
    ProfileDetails? data,
  }) =>
      ProfileGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory ProfileGetModel.fromJson(Map<String, dynamic> json) => ProfileGetModel(
    title: json["title"],
    data: json["data"] == null ? null : ProfileDetails.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class ProfileDetails {
  int? id;
  String? name;
  String? displayName;
  String? appToken;
  String? email;
  String? phone;
  String? image;
  int? status;
  int? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileDetails({
    this.id,
    this.name,
    this.displayName,
    this.appToken,
    this.email,
    this.phone,
    this.image,
    this.status,
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  ProfileDetails copyWith({
    int? id,
    String? name,
    String? displayName,
    String? appToken,
    String? email,
    String? phone,
    String? image,
    int? status,
    int? roleId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ProfileDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        displayName: displayName ?? this.displayName,
        appToken: appToken ?? this.appToken,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        status: status ?? this.status,
        roleId: roleId ?? this.roleId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
    id: json["id"],
    name: json["name"],
    displayName: json["display_name"],
    appToken: json["app_token"],
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
    "email": email,
    "phone": phone,
    "image": image,
    "status": status,
    "role_id": roleId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
