import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty_waysfluttedo/view/auth/signup_page.dart';
import '../../controller/auth/profile_controller.dart';
import '../../controller/login_controller.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';
import '../forgot_password/request_reset.dart';
import '../main_panel.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const String path = '/login';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: GetBuilder<LoginController>(
              init: LoginController(),
              builder: (controller) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: form,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: emailController,
                            validator: FormValidator().validateEmail,
                            hint: "Enter your email",
                            title: "Email",
                            prefixIcon: const Icon(Icons.mail_outline),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: passwordController,
                            isPasswordField: true,
                            validator: FormValidator().validatePassword,
                            hint: "Enter your password",
                            title: "Password",
                            prefixIcon: const Icon(Icons.password_outlined),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RequestReset.path);
                                },
                                child: const Text("Forgot password?"),
                              ),
                            ],
                          ),
                          CustomElevatedButton(
                            onPressed: () async {
                              ProfileController ctrl =
                                  ProfileController(context);
                              if (form.currentState!.validate()) {
                                var navigator = Navigator.of(context);
                                bool success = await controller.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                                if (success) {
                                  ProfileController profileController =
                                      Get.put(ctrl);
                                  navigator.pushNamedAndRemoveUntil(
                                    MainPanel.path,
                                    (r) => false,
                                  );
                                }
                              }
                            },
                            loading: controller.loading,
                            text: "Login",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account ?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, SignupPage.path);
                                },
                                child: const Text("signup"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
