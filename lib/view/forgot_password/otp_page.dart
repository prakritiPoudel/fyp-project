import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controller/auth/password_reset_controller.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';
import 'reset_password.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});
  static const String path = '/otpPage';
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP page"),
      ),
      body: Form(
        key: form,
        child: GetBuilder<PasswordResetController>(
            init: PasswordResetController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "We have sent an email to $email with OTP code. Enter the otp here",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      hint: "Enter otp code",
                      title: "OTP Code",
                      validator: (value) {
                        if (value == null || value.toString() == "") {
                          return "Enter otp code";
                        } else if (value.toString().length != 6) {
                          return "Please enter 6 digit code";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(
                      onPressed: () async {
                        var navigator = Navigator.of(context);
                        if (form.currentState!.validate()) {
                          bool success = await controller.verifyToken(
                            email,
                            otpController.text,
                          );
                          if (success) {
                            navigator.pushNamed(
                              ResetPassword.path,
                              arguments: otpController.text,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(msg: "Please enter otp code");
                        }
                      },
                      text: "Get OTP Code",
                      loading: controller.verifyTokenLoading,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
