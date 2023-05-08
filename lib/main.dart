import 'package:flutter/material.dart';
import 'package:sporty_waysfluttedo/utils/constants.dart';
import 'package:sporty_waysfluttedo/view/transaction_view.dart';
import 'view/auth/change_password.dart';
import 'view/auth/login_page.dart';
import 'view/auth/signup_page.dart';
import 'view/auth/update_profile.dart';
import 'view/checkout_page.dart';
import 'view/details_page/detail_page.dart';
import 'view/details_page/venue_slots_details.dart';
import 'view/favourite_venues.dart';
import 'view/forgot_password/otp_page.dart';
import 'view/forgot_password/request_reset.dart';
import 'view/forgot_password/reset_password.dart';
import 'view/homepage/view_by.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'view/main_panel.dart';
import 'view/search_page.dart';
import 'view/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_833c2ea7ee2443879c25e755d4ff2567",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Sporty Ways',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: primaryColor,
              appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: primaryColor,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: ElevatedButton.styleFrom(
                  foregroundColor: primaryColor,
                ),
              ),
              // bottomNavigationBarTheme: BottomNavigationBarThemeData(
              //   backgroundColor: primaryColor,
              //   selectedItemColor: Colors.white,
              //   unselectedItemColor: Colors.grey,
              // ),
              inputDecorationTheme: InputDecorationTheme(
                iconColor: primaryColor,
                prefixIconColor: primaryColor,
                suffixIconColor: primaryColor,
              ),
              radioTheme: RadioThemeData(
                fillColor: MaterialStatePropertyAll(primaryColor),
              ),
            ),
            home: const SplashPage(),
            routes: {
              SearchPage.path: (_) => const SearchPage(),
              MainPanel.path: (_) => MainPanel(),
              LoginPage.path: (_) => LoginPage(),
              SignupPage.path: (_) => SignupPage(),
              DetailsPage.path: (_) => const DetailsPage(),
              UpdateProfile.path: (_) => UpdateProfile(),
              ChangePassword.path: (_) => const ChangePassword(),
              VenueSlotsDetails.path: (_) => const VenueSlotsDetails(),
              CheckoutPage.path: (_) => CheckoutPage(),
              FavouriteVenues.path: (_) => const FavouriteVenues(),
              ViewBy.path: (_) => const ViewBy(),
              RequestReset.path: (_) => RequestReset(),
              OtpPage.path: (_) => OtpPage(),
              ResetPassword.path: (_) => ResetPassword(),
              TransactionView.path: (_) => const TransactionView(),
            },
          );
        });
  }
}
