import 'dart:convert';

import 'package:get/get.dart';

import '../model/transaction_model.dart';
import '../utils/remote_services.dart';

class TransactionController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  DateTime pickedDate = DateTime.now();

  List<TransactionModel> transactions = [];
  loadTransactions() async {
    loading = true;
    update();
    var response = await RemoteServices().transaction(pickedDate);
    transactions = transactionModelFromJson(json.encode(response.data['data']));
    loading = false;
    update();
  }

  updateDate(DateTime date) {
    pickedDate = date;
    update();
    loadTransactions();
  }
}
