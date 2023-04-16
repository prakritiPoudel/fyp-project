import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/venue_slots_controller.dart';
import '../../model/venue_detail_model.dart';
import 'bottom_nav_bar.dart';
import 'date_picker.dart';
import 'legend.dart';
import 'slots_list_view.dart';

class VenueSlotsDetails extends StatelessWidget {
  const VenueSlotsDetails({super.key});
  static const String path = '/venue/slots';
  @override
  Widget build(BuildContext context) {
    final VenueDetailModel model =
        ModalRoute.of(context)!.settings.arguments as VenueDetailModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Date and Time"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<VenueSlotsController>(
          init: VenueSlotsController(model.id),
          builder: (controller) {
            return controller.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    bottomNavigationBar: BottomNavBar(
                      controller: controller,
                      venue: model,
                    ),
                    body: Column(
                      children: [
                        DatePicker(
                          controller: controller,
                        ),
                        Container(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Available time slots",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Legend(),
                        Container(height: 10),
                        SlotsListView(controller: controller),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
