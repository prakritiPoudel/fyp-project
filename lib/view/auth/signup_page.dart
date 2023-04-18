import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/auth/signup_controller.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';
import '../widgets/custom_text_field.dart';
import 'login_page.dart';

class SignupPage extends StatelessWidget {
  static const String path = '/signup';
  SignupPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "SignUp",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
            color: primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: GetBuilder<SignupController>(
              init: SignupController(),
              builder: (controller) {
                return Form(
                  key: form,
                  child: ListView(
                    children: [
                      const Center(child: Text("Create your new account")),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: emailController,
                        hint: "Enter your email",
                        title: "Email",
                        validator: FormValidator().validateEmail,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: usernameController,
                        hint: "Enter your username",
                        title: "Username",
                        validator: FormValidator().validateUsername,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: fullNameController,
                        hint: "Enter your full name",
                        title: "Full name",
                        validator: FormValidator().validateFullName,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: mobileController,
                        hint: "Enter your mobile number",
                        title: "Mobile no",
                        validator: FormValidator().validateMobileNumber,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 70,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 55,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: const Color(0xffD9D9D9),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (var item in genders)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Radio<String>(
                                            value: item,
                                            groupValue:
                                                controller.selectedGender,
                                            onChanged: (value) {
                                              if (value != null) {
                                                controller.changeGender(value);
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 5),
                                          Text(item.capitalizeFirst!),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 7,
                              left: 8,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                color: Colors.white,
                                child: const Text(
                                  "Gender",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: passwordController,
                        isPasswordField: true,
                        hint: "Enter your password",
                        title: "Password",
                        validator: FormValidator().validatePassword,
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          if (form.currentState!.validate()) {
                            if (controller.selectedGender == "") {
                              Fluttertoast.showToast(
                                msg: "Please select gender",
                              );
                            } else {
                              var navigator = Navigator.of(context);
                              bool success = await controller.signup(
                                email: emailController.text,
                                username: usernameController.text,
                                fullName: fullNameController.text,
                                gender: controller.selectedGender,
                                mobileNumber: mobileController.text,
                                password: passwordController.text,
                              );
                              if (success) {
                                navigator.pushNamedAndRemoveUntil(
                                  LoginPage.path,
                                  (route) => false,
                                );
                              }
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("Register"),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
