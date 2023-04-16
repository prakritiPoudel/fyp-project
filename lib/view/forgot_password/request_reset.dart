import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/auth/password_reset_controller.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';
import 'otp_page.dart';

class RequestReset extends StatelessWidget {
  RequestReset({super.key});
  static const String path = '/resetPassword';
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset password"),
      ),
      body: GetBuilder<PasswordResetController>(
          init: PasswordResetController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: emailController,
                    title: "Email Address",
                    hint: "Enter email address",
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    onPressed: () async {
                      var navigator = Navigator.of(context);
                      if (emailController.text == "") {
                        Fluttertoast.showToast(
                            msg: "Please enter email address");
                      } else {
                        bool success =
                            await controller.requestReset(emailController.text);
                        if (success) {
                          navigator.pushNamed(
                            OtpPage.path,
                            arguments: emailController.text,
                          );
                        }
                      }
                    },
                    text: "Get OTP code",
                    loading: controller.requestResetLoading,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
