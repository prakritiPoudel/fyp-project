import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/auth/profile_model.dart';
import '../../utils/remote_services.dart';
import '../../view/auth/login_page.dart';

class ProfileController extends GetxController {
  RxBool loading = false.obs;
  final BuildContext context;

  ProfileController(this.context);

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  late ProfileModel profile;
  fetchProfile() async {
    var navigator = Navigator.of(context);
    loading.value = true;
    var response = await RemoteServices().readProfile();
    log(response.data.toString());
    if (response.data['status']) {
      profile = ProfileModel.fromJson(response.data['data']);
    } else {
      navigator.pushNamedAndRemoveUntil(LoginPage.path, (route) => false);
    }
    loading.value = false;
    update();
  }

  refreshProfile() async {
    var response = await RemoteServices().readProfile();
    if (response.data['data'] != false) {
      profile = ProfileModel.fromJson(response.data['data']);
      update();
    } else {}
  }
}
