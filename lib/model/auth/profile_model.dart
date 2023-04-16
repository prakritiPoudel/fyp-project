// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import '../../utils/remote_services.dart';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNo,
    required this.gender,
    required this.type,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String username;
  String email;
  String fullName;
  String phoneNo;
  String gender;
  String type;
  String profilePicture;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        fullName: json["full_name"],
        phoneNo: json["phone_no"],
        gender: json["gender"],
        type: json["type"],
        profilePicture: RemoteServices().media + json["profile_picture"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "full_name": fullName,
        "phone_no": phoneNo,
        "gender": gender,
        "type": type,
        "profile_picture": profilePicture,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
