import 'dart:convert';

import 'package:get/get.dart';
import '../model/amenities_model.dart';
import '../model/feedbacks_listing_model.dart';
import '../model/venue_detail_model.dart';
import '../utils/remote_services.dart';

class VenueDetailController extends GetxController {
  bool loading = true;

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  final int id;
  VenueDetailController({required this.id});
  late VenueDetailModel model;
  loadDetails() async {
    loading = true;
    update();
    var response = await RemoteServices().fetchVenuesByid(id);
    model = venueDetailModelFromJson(json.encode(response.data['data']));
    checkIsFav();
    loadAmenities();
    loading = false;
    update();
    loadFeedbacks();
  }

  List<AmenityModel> amenities = [];

  loadAmenities() async {
    var response = await RemoteServices().fetchVenuesAmenities(id);
    amenities = amenityModelFromJson(json.encode(response.data['data']));
    update();
  }

  List<FeedbackListingModel> feedbacks = [];
  loadFeedbacks() async {
    var response = await RemoteServices().fetchFeedbacks(id);
    feedbacks = feedbackListingModelFromJson(
      json.encode(
        response.data['data'],
      ),
    );
    update();
  }

  // for rating
  double initialRating = 2.5;
  double rating = 2.5;
  changeRating(double val) {
    rating = val;
    update();
  }

  Future<void> submitRating(String review) async {
    var response = await RemoteServices().postFeedback(
      venueId: model.id,
      rating: rating,
      review: review,
    );
    loadDetails();
    return;
  }

  bool isFav = false;

  checkIsFav() async {
    var response = await RemoteServices().isFav(id);
    isFav = response.data['status'];
    update();
  }

  toggleFav() async {
    var response = await RemoteServices().addToFav(id);
    await checkIsFav();
  }
}
