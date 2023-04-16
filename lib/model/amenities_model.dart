import 'dart:convert';
import '../utils/remote_services.dart';

List<AmenityModel> amenityModelFromJson(String str) => List<AmenityModel>.from(
    json.decode(str).map((x) => AmenityModel.fromJson(x)));

class AmenityModel {
  AmenityModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String icon;
  DateTime createdAt;
  DateTime updatedAt;

  factory AmenityModel.fromJson(Map<String, dynamic> json) => AmenityModel(
        id: json["id"],
        name: json["name"],
        icon: RemoteServices().media + json["icon"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
