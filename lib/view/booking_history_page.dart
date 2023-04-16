import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/booking_history_controller.dart';
import '../model/booking_history_model.dart';
import 'details_page/detail_page.dart';

class BookingHistoryPage extends StatelessWidget {
  const BookingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<BookingHistoryController>(
          init: BookingHistoryController(),
          builder: (controller) {
            return ListView(
              children: [
                const Text(
                  "Bookings up to next 7 days",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 170,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (c, i) => const SizedBox(width: 10),
                    itemCount: controller.thisWeek.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      BookingHistoryModel model = controller.thisWeek[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            DetailsPage.path,
                            arguments: model.venueId,
                          );
                        },
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            width: context.width * 0.8,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken,
                                ),
                                image: NetworkImage(model.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.venueName,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "${DateFormat("MMMM dd").format(model.bookedDate)} | ${model.quantity} person",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${model.beginTime} to ${model.endTime}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Complete history",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (c, i) => const SizedBox(height: 10),
                  shrinkWrap: true,
                  itemCount: controller.oldBookings.length,
                  itemBuilder: (context, index) {
                    BookingHistoryModel model = controller.oldBookings[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(DetailsPage.path,
                            arguments: model.venueId);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  model.image,
                                  height: 100,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      model.venueName,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        "${DateFormat("MMMM dd").format(model.bookedDate)} | ${model.quantity} person"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
