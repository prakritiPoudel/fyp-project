// To parse this JSON data, do
//
//     final venueSlotsModel = venueSlotsModelFromJson(jsonString);

import 'dart:convert';

List<VenueSlotsModel> venueSlotsModelFromJson(String str) =>
    List<VenueSlotsModel>.from(
        json.decode(str).map((x) => VenueSlotsModel.fromJson(x)));

class VenueSlotsModel {
  VenueSlotsModel({
    required this.id,
    required this.venueId,
    required this.beginTime,
    required this.endTime,
    required this.capacity,
    required this.price,
    required this.discount,
    required this.message,
  });

  int id;
  int venueId;
  String beginTime;
  String endTime;
  int capacity;
  double price;
  double discount;
  String message;

  factory VenueSlotsModel.fromJson(Map<String, dynamic> json) =>
      VenueSlotsModel(
        id: json["id"],
        venueId: json["venue_id"],
        beginTime: json["begin_time"],
        endTime: json["end_time"],
        capacity: int.tryParse(json['capacity'].toString()) ?? 0,
        price: double.tryParse(json["price"].toString()) ?? 0,
        discount: double.tryParse(json["discount"].toString()) ?? 0,
        message: json["message"],
      );
}
