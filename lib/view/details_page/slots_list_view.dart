import 'package:flutter/material.dart';

import '../../controller/venue_slots_controller.dart';
import '../../model/venue_slots_model.dart';

class SlotsListView extends StatelessWidget {
  const SlotsListView({
    super.key,
    required this.controller,
  });
  final VenueSlotsController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.slots.length,
        itemBuilder: (context, index) {
          VenueSlotsModel model = controller.slots[index];
          return Card(
            color: controller.isAlreadyBooked(model)
                ? Colors.red.shade100
                : (controller.selectedSlot != null &&
                        controller.selectedSlot!.id == model.id)
                    ? Colors.green.shade100
                    : Colors.blue.shade100,
            elevation: 5,
            child: ListTile(
              onTap: () {
                controller.isAlreadyBooked(model)
                    ? null
                    : controller.selectSlot(model);
              },
              title: Text(
                "${model.beginTime} to ${model.endTime}",
              ),
              isThreeLine: true,
              trailing: controller.isAlreadyBooked(model)
                  ? const Text("Fully booked")
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rs. ${model.price}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${model.capacity - controller.getBooked(model)} Remaining",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
              subtitle: model.message == "" || model.discount != 0
                  ? Text("Rs. ${model.discount}/- Discount\n${model.message}")
                  : Text(model.message),
            ),
          );
        },
      ),
    );
  }
}
