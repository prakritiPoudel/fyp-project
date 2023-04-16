import 'dart:convert';

import 'package:get/get.dart';

import '../model/venue_listing_model.dart';
import '../utils/remote_services.dart';

class VenueController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    loadVenues();
  }

  List<VenueListingModel> venues = <VenueListingModel>[];

  loadVenues() async {
    loading = true;
    update();
    var response = await RemoteServices().fetchVenues();
    venues = venueListingModelFromJson(json.encode(response.data['data']));
    loading = false;
    update();
  }
}
