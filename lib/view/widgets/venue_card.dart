import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import '../../model/venue_listing_model.dart';
import '../details_page/detail_page.dart';

class VenueDetailCard extends StatelessWidget {
  const VenueDetailCard({
    super.key,
    required this.venue,
  });

  final VenueListingModel venue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                DetailsPage.path,
                arguments: venue.id,
              );
            },
            child: Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height: 250,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 194, 193, 193)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  venue.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.karla(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${venue.cityName},",
                                      maxLines: 1,
                                      style: GoogleFonts.karla(fontSize: 13),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        venue.location,
                                        maxLines: 1,
                                        style: GoogleFonts.karla(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.star, color: Colors.yellow),
                          Text(venue.avgRating.toStringAsFixed(1))
                        ],
                      ),
                      const SizedBox(
                        height: 160,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          right: 4.0,
                        ),
                        child: SizedBox(
                          height: 20,
                          width: 300,
                          child: Marquee(
                              text: "ChangingRoom, Washroom, equiments",
                              style: const TextStyle(fontSize: 13),
                              scrollAxis: Axis.horizontal,
                              blankSpace: 150.0,
                              velocity: 500,
                              pauseAfterRound: const Duration(
                                seconds: 5,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 10,
            right: 10,
            child: Container(
              height: 140,
              width: 330,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    alignment: const Alignment(-.2, 0),
                    image: NetworkImage(
                      venue.bannerImage,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
