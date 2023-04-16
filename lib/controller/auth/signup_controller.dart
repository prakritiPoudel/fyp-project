import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../utils/remote_services.dart';

class SignupController extends GetxController {
  bool obsecurepassword = true;

  togglePassword() {
    obsecurepassword = !obsecurepassword;
    update();
  }

  String selectedGender = "";
  changeGender(String gender) {
    selectedGender = gender;
    update();
  }

  bool loading = false;

  Future<bool> signup({
    required String email,
    required String username,
    required String fullName,
    required String gender,
    required String mobileNumber,
    required String password,
  }) async {
    loading = true;
    update();
    var response = await RemoteServices().signup(
      email: email,
      username: username,
      fullName: fullName,
      gender: gender,
      mobileNumber: mobileNumber,
      password: password,
    );
    loading = false;
    update();
    Fluttertoast.showToast(msg: response.data['message']);
    return response.data['status'];
  }
}
