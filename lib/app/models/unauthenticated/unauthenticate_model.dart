import 'dart:convert';

UnatuhenticateModel unatuhenticateModelFromJson(String str) => UnatuhenticateModel.fromJson(json.decode(str));

String unatuhenticateModelToJson(UnatuhenticateModel data) => json.encode(data.toJson());

class UnatuhenticateModel {
  String? message;

  UnatuhenticateModel({
    this.message,
  });

  UnatuhenticateModel copyWith({
    String? message,
  }) =>
      UnatuhenticateModel(
        message: message ?? this.message,
      );

  factory UnatuhenticateModel.fromJson(Map<String, dynamic> json) => UnatuhenticateModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
