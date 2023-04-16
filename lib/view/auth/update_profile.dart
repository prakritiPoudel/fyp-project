import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/auth/profile_controller.dart';
import '../../controller/auth/update_profile_controller.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});
  static const String path = '/editprofile';
  ProfileController profileController = Get.find();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
      ),
      body: Form(
        key: form,
        child: GetBuilder<UpdateProfileController>(
          init: UpdateProfileController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: Center(
                      child: controller.profileImage.path == ""
                          ? profileController.profile.profilePicture == ""
                              ? const CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      AssetImage("assets/user.png"),
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    profileController.profile.profilePicture,
                                  ),
                                )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  FileImage(controller.profileImage),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CustomTextField(
                            controller: controller.fullNameController,
                            hint: "Enter full name",
                            title: "Full name",
                            validator: FormValidator().validateFullName,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: CustomTextField(
                            controller: controller.emailController,
                            hint: "Enter email address",
                            title: "Email",
                            validator: FormValidator().validateEmail,
                          ),
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
                                                  controller
                                                      .changeGender(value);
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: CustomTextField(
                            controller: controller.phoneNumberController,
                            hint: "Enter phone number",
                            title: "Phone number",
                            validator: FormValidator().validateMobileNumber,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CustomElevatedButton(
                      onPressed: () async {
                        if (form.currentState!.validate()) {
                          if (controller.selectedGender != "") {
                            var navigator = Navigator.of(context);
                            bool success = await controller.updateProfile();
                            if (success) {
                              navigator.pop();
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please select a gender",
                            );
                          }
                        }
                      },
                      loading: controller.updating,
                      text: "Update",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
