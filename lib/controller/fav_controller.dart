import 'dart:convert';

import 'package:get/get.dart';
import '../model/venue_listing_model.dart';
import '../utils/remote_services.dart';

class FAVController extends GetxController {
  bool loading = false;

  @override
  //override onInit method of superclassx
  void onInit() {
    super.onInit();
    loadFavouriteVenues();
  }

  List<VenueListingModel> venues = <VenueListingModel>[];

  loadFavouriteVenues() async {
    loading = true;
    update();
    var response = await RemoteServices().myFavs();
    venues = venueListingModelFromJson(json.encode(response.data['data']));
    loading = false;
    update();
  }
}
