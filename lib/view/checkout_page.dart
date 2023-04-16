import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../controller/checkout_controller.dart';
import '../model/venue_detail_model.dart';
import '../model/venue_slots_model.dart';
import 'main_panel.dart';
import 'widgets/custom_elevated_button.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});
  static const String path = '/checkout';
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final CheckoutNavModel model =
        ModalRoute.of(context)!.settings.arguments as CheckoutNavModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<CheckoutController>(
          init: CheckoutController(model: model),
          builder: (controller) {
            return ListView(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.venue.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(model.venue.location),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            model.venue.avgRating.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                const Text(
                  "Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                tile("Entry time", model.slot.beginTime),
                tile("Exit time", model.slot.endTime),
                tile("Quantity", "${model.quantity} persons"),
                tile(
                  "Rate",
                  "${model.slot.price} / person",
                ),
                tile(
                  "Subtotal",
                  "Rs. ${model.slot.price * model.quantity}",
                ),
                tile(
                  "Discount",
                  "Rs. ${model.slot.discount * model.quantity}",
                ),
                const SizedBox(height: 10),
                Container(height: 1, color: Colors.grey),
                const SizedBox(height: 10),
                tile(
                  "Grand total",
                  "Rs. ${(model.slot.price - model.slot.discount) * model.quantity}",
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: "Checkout with KHALTI",
                  loading: controller.loading,
                  onPressed: () async {
                    var navigator = Navigator.of(context);

                    final config = PaymentConfig(
                      amount: 10000,
                      productIdentity: 'dell-g5-g5510-2021',
                      productName: 'Dell G5 G5510 2021',
                      productUrl: 'https://www.khalti.com/#/bazaar',
                    );

                    KhaltiScope.of(context).pay(
                      config: config,
                      preferences: const [
                        PaymentPreference.khalti,
                        PaymentPreference.eBanking,
                      ],
                      onSuccess: (successModel) async {
                        bool success = await controller.checkout(
                          successModel.idx,
                        );
                        if (success) {
                          navigator.pushNamedAndRemoveUntil(
                            MainPanel.path,
                            (route) => false,
                          );
                        }
                      },
                      onFailure: (failureModel) {
                        Fluttertoast.showToast(msg: failureModel.message);
                      },
                      onCancel: () {
                        Fluttertoast.showToast(msg: "Payment cancelled");
                      },
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

  ListTile tile(String leading, String trailing) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        leading,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: Text(trailing),
    );
  }
}

class CheckoutNavModel {
  final DateTime date;
  final VenueSlotsModel slot;
  final int quantity;
  final VenueDetailModel venue;

  CheckoutNavModel({
    required this.date,
    required this.slot,
    required this.quantity,
    required this.venue,
  });
}
