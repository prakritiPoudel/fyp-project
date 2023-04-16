import 'dart:convert';

import 'package:get/get.dart';
import '../model/venue_listing_model.dart';
import '../utils/remote_services.dart';
import '../view/homepage/view_by.dart';

class ViewByController extends GetxController {
  bool loading = false;
  final ViewByModel model;

  ViewByController(this.model);

  @override
  void onInit() {
    super.onInit();
    loadVenues();
  }

  List<VenueListingModel> venues = <VenueListingModel>[];

  loadVenues() async {
    loading = true;
    update();
    var response = await RemoteServices().queryVenues(model.query, model.value);
    venues = venueListingModelFromJson(json.encode(response.data['data']));
    loading = false;
    update();
  }
}
