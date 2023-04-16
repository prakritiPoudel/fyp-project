import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../utils/remote_services.dart';

class ChangePasswordController extends GetxController {
  bool isLoading = false;

  changePassword(
    BuildContext context,
    String email,
    String currentPassword,
    String newPassword,
  ) async {
    isLoading = true;
    update();
    var response = await RemoteServices().changePassword(
      email,
      currentPassword,
      newPassword,
    );
    if (response.data.toString().contains('Invalid Credentials.')) {
      Fluttertoast.showToast(msg: "The Email or password did not match");
    } else {
      log(response.data.toString());

      Fluttertoast.showToast(msg: "Password has been changed");
    }

    isLoading = false;
    update();
  }

  bool currentPasswordVisible = true;
  bool newPasswordVisible = true;
  bool newPasswordConfirmPassword = true;
  toggleCurrentPasswordVisible() {
    currentPasswordVisible = !currentPasswordVisible;
    update();
  }

  toggleNewPasswordVisible() {
    newPasswordVisible = !newPasswordVisible;
    update();
  }

  toggleNewPasswordConfirmVisible() {
    newPasswordConfirmPassword = !newPasswordConfirmPassword;
    update();
  }
}
