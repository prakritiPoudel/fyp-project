// To parse this JSON data, do
//
//     final venueDetailModel = venueDetailModelFromJson(jsonString);

import 'dart:convert';
import '../utils/remote_services.dart';

VenueDetailModel venueDetailModelFromJson(String str) =>
    VenueDetailModel.fromJson(json.decode(str));

String venueDetailModelToJson(VenueDetailModel data) =>
    json.encode(data.toJson());

class VenueDetailModel {
  VenueDetailModel({
    required this.id,
    required this.name,
    required this.location,
    required this.openingTime,
    required this.closingTime,
    required this.rules,
    required this.email,
    required this.phoneNumber,
    required this.bannerImage,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.avgRating,
    required this.ratings,
    required this.cityName,
    required this.categoryDetails,
  });

  int id;
  String name;
  String location;
  String openingTime;
  String closingTime;
  String rules;
  String email;
  String phoneNumber;
  String bannerImage;
  int ownerId;
  DateTime createdAt;
  DateTime updatedAt;
  double avgRating;
  double ratings;
  String cityName;
  CategoryDetails categoryDetails;

  factory VenueDetailModel.fromJson(Map<String, dynamic> json) =>
      VenueDetailModel(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        rules: json["rules"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        bannerImage: RemoteServices().media + json["banner_image"],
        ownerId: json["owner_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        avgRating: double.tryParse(json["avg_rating"].toString()) ?? 0,
        ratings: double.tryParse(json["avg_rating"].toString()) ?? 0,
        cityName: json["city_name"],
        categoryDetails: CategoryDetails.fromJson(json["category_details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "rules": rules,
        "email": email,
        "phone_number": phoneNumber,
        "banner_image": bannerImage,
        "owner_id": ownerId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "avg_rating": avgRating,
        "ratings": ratings,
        "city_name": cityName,
        "category_details": categoryDetails.toJson(),
      };
}

class CategoryDetails {
  CategoryDetails({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String icon;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory CategoryDetails.fromJson(Map<String, dynamic> json) =>
      CategoryDetails(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
