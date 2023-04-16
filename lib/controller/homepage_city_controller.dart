import 'dart:convert';

import 'package:get/get.dart';

import 'package:sporty_waysfluttedo/model/cities_model.dart';
import 'package:sporty_waysfluttedo/utils/remote_services.dart';

class HomepageCityController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    loadCities();
  }

  List<CitiesModel> cities = <CitiesModel>[];

  loadCities() async {
    loading = true;
    update();
    var response = await RemoteServices().fetchCities();
    cities = citiesModelFromJson(json.encode(response.data['data']));
    loading = false;
    update();
  }
}
