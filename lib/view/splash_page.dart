import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth/profile_controller.dart';
import '../utils/constants.dart';
import '../utils/session.dart';
import 'auth/login_page.dart';
import 'main_panel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  navigate() async {
    var navigator = Navigator.of(context);
    int? id = await Session().readId();
    Future.delayed(const Duration(seconds: 4)).whenComplete(() {
      if (id == null) {
        navigator.pushNamedAndRemoveUntil(LoginPage.path, (route) => false);
      } else {
        ProfileController profileController =
            Get.put(ProfileController(context));
        navigator.pushNamedAndRemoveUntil(MainPanel.path, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset("assets/booking.gif"),
            ),
          ),
          const Spacer(),
          const Text("SPORTY WAYS ©️ 2023"),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: LinearProgressIndicator(
              minHeight: 2,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
