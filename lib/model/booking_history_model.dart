// To parse this JSON data, do
//
//     final bookingHistoryModel = bookingHistoryModelFromJson(jsonString);

import 'dart:convert';

import '../utils/remote_services.dart';

List<BookingHistoryModel> bookingHistoryModelFromJson(String str) =>
    List<BookingHistoryModel>.from(
        json.decode(str).map((x) => BookingHistoryModel.fromJson(x)));

String bookingHistoryModelToJson(List<BookingHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingHistoryModel {
  BookingHistoryModel({
    required this.id,
    required this.venueId,
    required this.slotId,
    required this.quantity,
    required this.bookedDate,
    required this.paymentId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.venueName,
    required this.image,
    required this.beginTime,
    required this.endTime,
    required this.paidAmount,
  });

  int id;
  int venueId;
  int slotId;
  int quantity;
  DateTime bookedDate;
  int paymentId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  String venueName;
  String image;
  String beginTime;
  String endTime;
  int paidAmount;

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) =>
      BookingHistoryModel(
        id: json["id"],
        venueId: json["venue_id"],
        slotId: json["slot_id"],
        quantity: json["quantity"],
        bookedDate: DateTime.parse(json["booked_date"]),
        paymentId: json["payment_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        venueName: json["venue_name"],
        image: RemoteServices().media + json["image"],
        beginTime: json["begin_time"],
        endTime: json["end_time"],
        paidAmount: json["paid_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "venue_id": venueId,
        "slot_id": slotId,
        "quantity": quantity,
        "booked_date":
            "${bookedDate.year.toString().padLeft(4, '0')}-${bookedDate.month.toString().padLeft(2, '0')}-${bookedDate.day.toString().padLeft(2, '0')}",
        "payment_id": paymentId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "venue_name": venueName,
        "image": image,
        "begin_time": beginTime,
        "end_time": endTime,
        "paid_amount": paidAmount,
      };
}
