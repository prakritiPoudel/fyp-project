import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth/change_password_controller.dart';
import '../../controller/auth/profile_controller.dart';
import '../../utils/validators.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  static const String path = "/changePassword";
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController email = TextEditingController();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordConfirm = TextEditingController();
  GlobalKey<FormState> changePassform = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ProfileController profileController = Get.find();
    email.text = profileController.profile.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: changePassform,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  CustomTextField(
                    controller: email,
                    title: "Email address",
                    hint: "Enter email address",
                    validator: FormValidator().validateEmail,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    isPasswordField: true,
                    controller: currentPassword,
                    title: "Current Password",
                    hint: "Enter current password",
                    validator: FormValidator().validatePassword,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    isPasswordField: true,
                    controller: newPassword,
                    title: "New password",
                    hint: "Enter new password",
                    validator: FormValidator().validatePassword,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    isPasswordField: true,
                    title: "Confirm new password",
                    hint: "Confirm new password",
                    controller: newPasswordConfirm,
                    validator: (value) {
                      if (newPassword.text != newPasswordConfirm.text) {
                        return "Password do not match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    loading: controller.isLoading,
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            if (changePassform.currentState!.validate()) {
                              controller.changePassword(
                                context,
                                email.text,
                                currentPassword.text,
                                newPassword.text,
                              );
                            } else {}
                          },
                    text: "Change Password",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
