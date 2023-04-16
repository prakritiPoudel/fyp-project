
import 'package:get/get.dart';

import '../../utils/remote_services.dart';

class PasswordResetController extends GetxController {
  bool obsecureNewPassword = true;
  bool obsecureConfirmNewPassword = true;

  toggleNewPassword() {
    obsecureNewPassword = !obsecureNewPassword;
    update();
  }

  toggleConfirmNewPassword() {
    obsecureConfirmNewPassword = !obsecureConfirmNewPassword;
    update();
  }

  bool requestResetLoading = false;
  Future<bool> requestReset(String email) async {
    requestResetLoading = true;
    update();
    var response = await RemoteServices().requestReset(email);
    requestResetLoading = false;
    update();
    return response.data['status'];
  }

  bool verifyTokenLoading = false;
  Future<bool> verifyToken(String email, String token) async {
    verifyTokenLoading = true;
    update();
    var response = await RemoteServices().verifyCode(email, token);
    verifyTokenLoading = false;
    update();
    return response.data['status'];
  }

  bool resetPasswordLoading = false;
  Future<bool> resetPassword(String token, String password) async {
    resetPasswordLoading = true;
    update();
    var response = await RemoteServices().resetPassword(token, password);
    resetPasswordLoading = false;
    update();
    return response.data['status'];
  }
}
