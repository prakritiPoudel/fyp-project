import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/fav_controller.dart';
import '../model/venue_listing_model.dart';
import '../utils/remote_services.dart';
import 'widgets/venue_card.dart';

class FavouriteVenues extends StatelessWidget {
  const FavouriteVenues({super.key});
  static const String path = "/favourites";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: GetBuilder<FAVController>(
        init: FAVController(),
        builder: (controller) {
          return controller.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.venues.isEmpty
                  ? const Center(
                      child: Text("Nothing in favourite till now"),
                    )
                  : ListView.builder(
                      itemCount: controller.venues.length,
                      itemBuilder: (context, index) {
                        VenueListingModel model = controller.venues[index];
                        return Stack(
                          children: [
                            VenueDetailCard(venue: model),
                            Positioned(
                              top: 12,
                              right: 50,
                              child: IconButton(
                                onPressed: () async {
                                  await RemoteServices().addToFav(model.id);
                                  controller.loadFavouriteVenues();
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
        },
      ),
    );
  }
}
