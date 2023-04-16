// To parse this JSON data, do
//
//     final feedbackListingModel = feedbackListingModelFromJson(jsonString);

import 'dart:convert';

import '../utils/remote_services.dart';

List<FeedbackListingModel> feedbackListingModelFromJson(String str) =>
    List<FeedbackListingModel>.from(
        json.decode(str).map((x) => FeedbackListingModel.fromJson(x)));

String feedbackListingModelToJson(List<FeedbackListingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackListingModel {
  FeedbackListingModel({
    required this.id,
    required this.review,
    required this.rating,
    required this.username,
    required this.fullName,
    required this.profilePicture,
  });

  int id;
  String review;
  double rating;
  String username;
  String fullName;
  String profilePicture;

  factory FeedbackListingModel.fromJson(Map<String, dynamic> json) =>
      FeedbackListingModel(
        id: json["id"],
        review: json["review"],
        rating: json["rating"]?.toDouble(),
        username: json["username"] ?? "Anon",
        fullName: json["full_name"] ?? "Anon",
        profilePicture: json["profile_picture"] == null
            ? "https://friconix.com/jpg/fi-cnluxx-anonymous-user-circle.jpg"
            : RemoteServices().media + json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "review": review,
        "rating": rating,
        "username": username,
        "full_name": fullName,
        "profile_picture": profilePicture,
      };
}
