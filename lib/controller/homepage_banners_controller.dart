import 'dart:convert';

import 'package:get/get.dart';

import '../model/banner_model.dart';
import '../utils/remote_services.dart';

class HomepageBannerController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    loadBanners();
  }

  List<BannerModel> banners = <BannerModel>[];

  loadBanners() async {
    loading = true;
    update();
    var response = await RemoteServices().fetchBanners();
    banners = bannerModelFromJson(json.encode(response.data['data']));
    loading = false;
    update();
  }
}
