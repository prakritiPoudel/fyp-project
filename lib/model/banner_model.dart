// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';
import '../utils/remote_services.dart';

List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(
    json.decode(str).map((x) => BannerModel.fromJson(x)));

class BannerModel {
  BannerModel({
    required this.id,
    required this.banner,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String banner;
  DateTime createdAt;
  DateTime updatedAt;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        banner: RemoteServices().media + json["banner"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
