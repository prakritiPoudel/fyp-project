import 'package:flutter/material.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/transaction_controller.dart';
import '../model/transaction_model.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});
  static String path = "/transactions";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
      ),
      body: GetBuilder<TransactionController>(
        init: TransactionController(),
        builder: (controller) {
          return Column(
            children: [
              Card(
                elevation: 5.0,
                child: ListTile(
                  title: Text(
                    "Transaction - ${DateFormat('MMM yyyy').format(controller.pickedDate)}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () {
                      showMonthPicker(
                        context: context,
                        initialDate: controller.pickedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      ).then(
                        (value) {
                          if (value != null) {
                            controller.updateDate(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              controller.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.transactions.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "No transactions made for ${DateFormat('MMM yyyy').format(controller.pickedDate)}"),
                              TextButton(
                                onPressed: () {
                                  controller.loadTransactions();
                                },
                                child: const Text("Refresh"),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: controller.transactions.length,
                            itemBuilder: (context, index) {
                              TransactionModel model =
                                  controller.transactions[index];
                              return ListTile(
                                title: Text(model.name),
                                leading: const Icon(
                                  Icons.trending_down,
                                  color: Colors.red,
                                ),
                                trailing: Text("Rs. ${model.amount}"),
                                subtitle: Text(
                                  DateFormat("MMMM dd, yyyy   hh:mm aa")
                                      .format(model.createdAt),
                                ),
                              );
                            },
                          ),
                        ),
            ],
          );
        },
      ),
    );
  }
}
