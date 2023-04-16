import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  const Legend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade100,
            ),
          ),
          const SizedBox(width: 5),
          const Text(
            "Available",
            style: TextStyle(fontSize: 13),
          ),
          const Spacer(),
          Container(
            height: 20,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.shade100,
            ),
          ),
          const SizedBox(width: 5),
          const Text(
            "Already booked",
            style: TextStyle(fontSize: 13),
          ),
          const Spacer(),
          Container(
            height: 20,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade100,
            ),
          ),
          const SizedBox(width: 5),
          const Text(
            "Selected",
            style: TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }
}
