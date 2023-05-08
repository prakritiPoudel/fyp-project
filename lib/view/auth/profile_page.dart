import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporty_waysfluttedo/view/auth/update_profile.dart';
import '../../controller/auth/profile_controller.dart';
import '../../utils/session.dart';
import '../favourite_venues.dart';
import '../transaction_view.dart';
import 'change_password.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 7,
              shadowColor: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 39, 116, 248),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GetBuilder<ProfileController>(
                    init: profileController,
                    builder: (controller) {
                      return Column(
                        children: [
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 140,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: controller.profile.profilePicture == ""
                                  ? Image.asset(
                                      "assets/user.png",
                                      color: Theme.of(context).iconTheme.color,
                                    )
                                  : Image.network(
                                      controller.profile.profilePicture,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.profile.fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text("@ ${controller.profile.username}"),
                          const SizedBox(height: 5),
                        ],
                      );
                    }),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Card(
            elevation: 5,
            child: ListTile(
              leading: const Icon(
                Icons.edit,
                color: Color.fromARGB(255, 33, 61, 243),
              ),
              title: const Text("Update Personal Details"),
              subtitle: const Text("your personal information"),
              onTap: () {
                Navigator.pushNamed(context, UpdateProfile.path);
              },
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
              title: const Text("Saved Venues"),
              subtitle: const Text("venues you added to favourites"),
              onTap: () {
                Navigator.pushNamed(context, FavouriteVenues.path);
              },
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              leading: const Icon(Icons.payment),
              title: const Text("Transactions"),
              subtitle: const Text("View all your transactions"),
              onTap: () {
                Navigator.pushNamed(context, TransactionView.path);
              },
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              leading: const Icon(
                Icons.password_outlined,
                color: Color.fromARGB(255, 48, 47, 47),
              ),
              title: const Text("Change password"),
              subtitle: const Text("Set a new password to secure your account"),
              onTap: () {
                Navigator.pushNamed(context, ChangePassword.path);
              },
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              subtitle: const Text("Log out from this app"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text(
                          "All of your session data will be lost are you sure?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () async {
                            var navigator = Navigator.of(context);
                            await Session().deleteId();
                            Get.delete<ProfileController>();
                            navigator.pushNamedAndRemoveUntil(
                              LoginPage.path,
                              (route) => false,
                            );
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
