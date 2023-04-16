import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/homepage_banners_controller.dart';
import '../../controller/homepage_category_controller.dart';
import '../../controller/homepage_city_controller.dart';
import '../../controller/venue_controller.dart';
import '../search_page.dart';
import '../side_drawer.dart';
import 'categories.dart';
import 'cities.dart';
import 'top_sliders.dart';
import 'venues.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomepageBannerController _homepageBannerController =
      HomepageBannerController();
  final HomepageCategoriesController _homepageCategoriesController =
      HomepageCategoriesController();
  final HomepageCityController _homepageCityController =
      HomepageCityController();
  final VenueController _venueController = VenueController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sporty Way"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.path);
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            _homepageBannerController.loadBanners();
            _homepageCategoriesController.loadCategories();
            _homepageCityController.loadCities();
            _venueController.loadVenues();
          },
          child: ListView(
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "Hurry! ",
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                      text: "Book your venue now",
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TopSliders(homepageBannerController: _homepageBannerController),
              const SizedBox(height: 5),
              Text(
                "Everything you need is in sporty way",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              HomepageCategories(
                  homepageCategoriesController: _homepageCategoriesController),
              const SizedBox(height: 15),
              Text(
                "Popular venues to play at",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              HomepageCities(homepageCityController: _homepageCityController),
              const SizedBox(height: 15),
              Row(
                children: const [
                  Text(
                    "Venues",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 5),
              HomepageVenues(venueController: _venueController),
            ],
          ),
        ),
      ),
    );
  }
}
