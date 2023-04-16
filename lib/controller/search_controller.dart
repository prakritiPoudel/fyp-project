import 'dart:convert';

import 'package:get/get.dart';

import 'package:sporty_waysfluttedo/model/venue_listing_model.dart';

import '../utils/remote_services.dart';

class SearchController extends GetxController {
  bool loading = false;

  List<VenueListingModel> searchResult = <VenueListingModel>[];

  loadVenues(String query) async {
    if (query.trim() == "") {
      searchResult.clear();
      update();
    } else {
      loading = true;
      update();
      var response = await RemoteServices().searchVenues(query);
      searchResult =
          venueListingModelFromJson(json.encode(response.data['data']));
      loading = false;
      update();
    }
  }
}
