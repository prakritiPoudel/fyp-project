import 'dart:convert';

List<TransactionModel> transactionModelFromJson(String str) =>
    List<TransactionModel>.from(
        json.decode(str).map((x) => TransactionModel.fromJson(x)));

String transactionModelToJson(List<TransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionModel {
  int id;
  int amount;
  String transactionId;
  int userId;
  int venueId;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.transactionId,
    required this.userId,
    required this.venueId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        amount: json["amount"],
        transactionId: json["transaction_id"],
        userId: json["user_id"],
        venueId: json["venue_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "transaction_id": transactionId,
        "user_id": userId,
        "venue_id": venueId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
      };
}
