import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/remote_services.dart';
import 'profile_controller.dart';

class UpdateProfileController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  ProfileController profileController = Get.find();
  @override
  void onInit() {
    super.onInit();
    fullNameController.text = profileController.profile.fullName;
    emailController.text = profileController.profile.email;
    phoneNumberController.text = profileController.profile.phoneNo;
    selectedGender = profileController.profile.gender;
  }

  String selectedGender = "";
  changeGender(String gender) {
    selectedGender = gender;
    update();
  }

  File profileImage = File("");
  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = File(image.path);
      update();
    }
  }

  bool updating = false;
  Future<bool> updateProfile() async {
    updating = true;
    update();
    var response = await RemoteServices().updateProfile(
      fullNameController.text,
      emailController.text,
      phoneNumberController.text,
      selectedGender,
      profileImage.path == "" ? null : profileImage,
    );
    log(response.data.toString());
    await profileController.refreshProfile();
    updating = false;
    update();
    return response.data['status'];
  }
}
