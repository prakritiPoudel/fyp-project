import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/venue_controller.dart';
import '../../model/venue_listing_model.dart';
import '../widgets/venue_card.dart';

class HomepageVenues extends StatelessWidget {
  const HomepageVenues({
    super.key,
    required VenueController venueController,
  }) : _venueController = venueController;

  final VenueController _venueController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VenueController>(
      init: _venueController,
      builder: (controller) {
        return controller.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.venues.length,
                itemBuilder: (context, index) {
                  VenueListingModel venue = controller.venues[index];
                  return VenueDetailCard(venue: venue);
                },
              );
      },
    );
  }
}
