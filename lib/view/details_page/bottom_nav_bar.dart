import 'package:flutter/material.dart';
import '../../controller/venue_slots_controller.dart';
import '../../model/venue_detail_model.dart';
import '../../utils/constants.dart';
import '../checkout_page.dart';
import '../widgets/custom_elevated_button.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.controller,
    required this.venue,
  });
  final VenueSlotsController controller;
  final VenueDetailModel venue;
  @override
  Widget build(BuildContext context) {
    return controller.selectedSlot != null
        ? Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Quantity : ${controller.quantity}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: controller.decreaseQuantity,
                        icon: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: controller.increaseQuantity,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      controller.selectedSlot!.discount == 0
                          ? Text(
                              "Rs. ${controller.selectedSlot!.price}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 23,
                                color: primaryColor,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Rs. ${controller.selectedSlot!.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 23,
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    decorationThickness: 2,
                                  ),
                                ),
                                Text(
                                  "Rs. ${controller.selectedSlot!.price - controller.selectedSlot!.discount}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: primaryColor,
                                  ),
                                )
                              ],
                            ),
                      const Spacer(),
                      CustomElevatedButton(
                        text: "Book Now",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            CheckoutPage.path,
                            arguments: CheckoutNavModel(
                              date: controller.selectedDate,
                              slot: controller.selectedSlot!,
                              quantity: controller.quantity,
                              venue: venue,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Please select a preferred slot",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
  }
}
