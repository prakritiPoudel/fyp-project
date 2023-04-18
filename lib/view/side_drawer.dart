import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Image.asset(
            "assets/Sporty way-logo.png",
            height: 145.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Contact Us",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Get in touch with us if you have any questions, need support or just want to learn more about Sporty Way",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.ptSans(
                      fontSize: 13,
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 10, 11, 102),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  " How Can I get in Touch ?",
                  style: TextStyle(
                      color: Color.fromARGB(255, 212, 35, 22), fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                const ListTile(
                  tileColor: Color.fromARGB(255, 239, 234, 234),
                  leading: Icon(Icons.email_outlined),
                  title: Text(
                    "Email",
                    style: TextStyle(
                      color: Color.fromARGB(255, 33, 82, 243),
                    ),
                  ),
                  subtitle: Text(
                    "For sales:@gmail.com\nFor support:@gmail.com",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
                const ListTile(
                  tileColor: Color.fromARGB(255, 239, 234, 234),
                  leading: Icon(Icons.call),
                  title: Text(
                    "Phone",
                    style: TextStyle(
                      color: Color.fromARGB(255, 33, 82, 243),
                    ),
                  ),
                  subtitle: Text(
                    "For sales:9825140732\nFor support:9834567890",
                    style: TextStyle(fontSize: 12),
                  ),
                  // isThreeLine: true,
                )
              ],
            ),
          ),
          const Spacer(),
          Text("Follow us on",
              style: GoogleFonts.ptSans(
                textStyle: TextStyle(fontSize: 16),
              )),
          Container(
            color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/facebook.png",
                    height: 20,
                    width: 20,
                    color: Colors.white,
                  ),
                  label: const Text("Facebook"),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/snapchat.png",
                    height: 20,
                    width: 20,
                    color: Colors.white,
                  ),
                  label: const Text("Snapchat"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
