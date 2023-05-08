import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sporty_waysfluttedo/utils/remote_services.dart';
import 'package:sporty_waysfluttedo/utils/session.dart';

class LoginController extends GetxController {
  bool loading = false;

  login(String email, String password) async {
    loading = true;
    update();
    var response = await RemoteServices().login(email, password);
    log(response.data.toString());
    Fluttertoast.showToast(msg: response.data['message']);
    if (response.data['status']) {
      Session().saveId(response.data['id']);
    }
    loading = false;
    update();
    return response.data['status'];
  }

  bool obsecurepassword = true;

  togglePassword() {
    obsecurepassword = !obsecurepassword;
    update();
  }
}
