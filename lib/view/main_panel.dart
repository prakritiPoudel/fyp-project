import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controller/main_panel_controller.dart';
import 'auth/profile_page.dart';
import 'booking_history_page.dart';
import 'homepage/home_page.dart';

class MainPanel extends StatelessWidget {
  static const String path = '/mainpanel';

  final MainPanelController _mainPanelController = MainPanelController();
  MainPanel({super.key});
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        backgroundColor: Color.fromARGB(255, 233, 230, 243),

        color: const Color.fromARGB(255, 18, 66, 211),
        activeColor: Colors.white,
        tabBackgroundColor: const Color.fromARGB(255, 18, 66, 211),
        curve: Curves.easeIn,
        gap: 5,
        tabBorderRadius: 3.0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // Obx(
        // () => BottomNavigationBar(
        selectedIndex: _mainPanelController.selectedPage.value,
        onTabChange: (int page) {
          _pageController.jumpToPage(page);
          _mainPanelController.changePage(page);
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.paste_sharp,
            text: "My Bookings",
          ),
          GButton(
            icon: Icons.account_circle_rounded,
            text: "Profile",
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (int page) {
          _mainPanelController.changePage(page);
        },
        controller: _pageController,
        children: [
          HomePage(),
          const BookingHistoryPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
