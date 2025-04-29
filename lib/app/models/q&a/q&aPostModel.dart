// To parse this JSON data, do
//
//     final qaAnswer = qaAnswerFromJson(jsonString);

import 'dart:convert';

QaAnswer qaAnswerFromJson(String str) => QaAnswer.fromJson(json.decode(str));

String qaAnswerToJson(QaAnswer data) => json.encode(data.toJson());

class QaAnswer {
  bool? status;
  String? message;
  AdminAns? data;

  QaAnswer({
    this.status,
    this.message,
    this.data,
  });

  QaAnswer copyWith({
    bool? status,
    String? message,
    AdminAns? data,
  }) =>
      QaAnswer(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory QaAnswer.fromJson(Map<String, dynamic> json) => QaAnswer(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : AdminAns.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AdminAns {
  String? adminId;
  String? type;
  int? qnaId;
  String? from;
  String? answer;
  String? productId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  AdminAns({
    this.adminId,
    this.type,
    this.qnaId,
    this.from,
    this.answer,
    this.productId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  AdminAns copyWith({
    String? adminId,
    String? type,
    int? qnaId,
    String? from,
    String? answer,
    String? productId,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      AdminAns(
        adminId: adminId ?? this.adminId,
        type: type ?? this.type,
        qnaId: qnaId ?? this.qnaId,
        from: from ?? this.from,
        answer: answer ?? this.answer,
        productId: productId ?? this.productId,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory AdminAns.fromJson(Map<String, dynamic> json) => AdminAns(
    adminId: json["admin_id"],
    type: json["type"],
    qnaId: json["qna_id"],
    from: json["from"],
    answer: json["answer"],
    productId: json["product_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "admin_id": adminId,
    "type": type,
    "qna_id": qnaId,
    "from": from,
    "answer": answer,
    "product_id": productId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
