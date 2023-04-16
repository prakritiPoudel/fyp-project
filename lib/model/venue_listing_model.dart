// To parse this JSON data, do
//
//     final venueListingModel = venueListingModelFromJson(jsonString);

import 'dart:convert';

import '../utils/remote_services.dart';

List<VenueListingModel> venueListingModelFromJson(String str) =>
    List<VenueListingModel>.from(
        json.decode(str).map((x) => VenueListingModel.fromJson(x)));

String venueListingModelToJson(List<VenueListingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VenueListingModel {
  VenueListingModel({
    required this.id,
    required this.name,
    required this.location,
    required this.bannerImage,
    required this.avgRating,
    required this.cityName,
  });
  int id;
  String name;
  String location;
  String bannerImage;
  double avgRating;
  String cityName;

  factory VenueListingModel.fromJson(Map<String, dynamic> json) =>
      VenueListingModel(
        id: json['id'],
        name: json["name"],
        location: json["location"],
        bannerImage: RemoteServices().media + json["banner_image"],
        avgRating: json['avg_rating'] == null
            ? 0
            : double.tryParse(json["avg_rating"].toString()) ?? 0,
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "banner_image": bannerImage,
        "avg_rating": avgRating,
        "city_name": cityName,
      };
}
