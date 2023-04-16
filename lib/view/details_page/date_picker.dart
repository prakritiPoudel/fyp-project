import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controller/venue_slots_controller.dart';
import '../../utils/constants.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.controller,
  });
  final VenueSlotsController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          return GestureDetector(
            onTap: () {
              controller.changeDate(date);
            },
            child: Card(
              elevation: 7,
              clipBehavior: Clip.hardEdge,
              color: controller.isSelected(date) ? primaryColor : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat("MMM").format(date),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color:
                            controller.isSelected(date) ? Colors.white : null,
                      ),
                    ),
                    Text(
                      DateFormat("dd").format(date),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color:
                            controller.isSelected(date) ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
