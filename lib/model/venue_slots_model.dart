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

// This code defines a class called VenueSlotsModel, which is used to represent 
// venue slots with various properties such as capacity, price, and discount.

// The class has a constructor that takes in required parameters such as id, venueId, 
// beginTime, endTime, capacity, price, discount, and message. 

// Additionally, there is a factory method called fromJson that takes a JSON map as input 
// and creates a new VenueSlotsModel object from it. The fromJson method applies some 
// type conversion checks using tryParse method to ensure that the values are correctly 
// cast to integers or doubles, respectively.

// There is also a function called venueSlotsModelFromJson that takes a JSON string as 
// input and converts it into a list of VenueSlotsModel objects. This function uses 
// the fromJson method defined in the VenueSlotsModel class to parse the JSON objects.
