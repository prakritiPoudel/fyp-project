import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/view_by_controller.dart';
import '../../model/venue_listing_model.dart';
import '../widgets/venue_card.dart';

class ViewBy extends StatelessWidget {
  const ViewBy({super.key});
  static const String path = '/viewby';
  @override
  Widget build(BuildContext context) {
    ViewByModel model =
        ModalRoute.of(context)!.settings.arguments as ViewByModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ViewByController>(
          init: ViewByController(model),
          builder: (controller) {
            return controller.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.venues.length,
                    itemBuilder: (context, index) {
                      VenueListingModel venue = controller.venues[index];
                      return VenueDetailCard(venue: venue);
                    },
                  );
          },
        ),
      ),
    );
  }
}

class ViewByModel {
  final String query;
  final String value;
  final String title;

  ViewByModel({
    required this.query,
    required this.value,
    required this.title,
  });
}
