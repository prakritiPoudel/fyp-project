// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

List<CitiesModel> citiesModelFromJson(String str) => List<CitiesModel>.from(
    json.decode(str).map((x) => CitiesModel.fromJson(x)));

String citiesModelToJson(List<CitiesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CitiesModel {
  CitiesModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
