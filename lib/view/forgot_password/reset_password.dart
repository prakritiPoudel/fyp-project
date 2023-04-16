import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controller/auth/password_reset_controller.dart';
import '../../utils/validators.dart';
import '../auth/login_page.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  static const String path = '/resetpassword';
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newConfirmPasswordController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String token = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset password"),
      ),
      body: GetBuilder<PasswordResetController>(
          init: PasswordResetController(),
          builder: (controller) {
            return Form(
              key: form,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: newPasswordController,
                      validator: FormValidator().validatePassword,
                      isPasswordField: true,
                      hint: "Enter new password",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: newConfirmPasswordController,
                      validator: (value) {
                        if (value != newPasswordController.text) {
                          return "Password didn't match";
                        }
                        return null;
                      },
                      hint: "Confirm new password",
                      isPasswordField: true,
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(
                      onPressed: () async {
                        var navigator = Navigator.of(context);
                        if (form.currentState!.validate()) {
                          bool success = await controller.resetPassword(
                            token,
                            newPasswordController.text,
                          );
                          if (success) {
                            Fluttertoast.showToast(
                                msg: "Password reset completed.");
                            navigator.pushNamedAndRemoveUntil(
                              LoginPage.path,
                              (route) => false,
                            );
                          }
                        }
                      },
                      text: "Set new password",
                      loading: controller.resetPasswordLoading,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
