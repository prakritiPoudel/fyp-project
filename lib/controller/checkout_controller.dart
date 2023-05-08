import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../utils/remote_services.dart';
import '../view/checkout_page.dart';

class CheckoutController extends GetxController {
  bool loading = false;

  final CheckoutNavModel model;

  CheckoutController({
    required this.model,
  });

  Future<bool> checkout(String transactionId) async {
    loading = true;
    update();
    Map<String, dynamic> data = {
      'venue_id': model.venue.id,
      'slot_id': model.slot.id,
      'quantity': model.quantity,
      'booked_date': model.date,
      'amount': (model.slot.price - model.slot.discount) * model.quantity,
      'transcation_id': transactionId,
    };
    var response = await RemoteServices().checkout(data);
    if (response.data['status']) {
      //Plugin to show a toast message on screen
      Fluttertoast.showToast(msg: response.data['message']);
    }
    loading = false;
    update();
    return response.data['status'];
  }
}
