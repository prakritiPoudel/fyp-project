import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty_waysfluttedo/view/details_page/venue_slots_details.dart';

import '../../controller/venue_detail_controller.dart';
import '../../model/amenities_model.dart';
import '../../model/feedbacks_listing_model.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});
  static const String path = '/detailpage';
  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int;
    return GetBuilder<VenueDetailController>(
        init: VenueDetailController(id: id),
        builder: (controller) {
          return controller.loading
              ? Scaffold(
                  appBar: AppBar(),
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          controller.toggleFav();
                        },
                        icon: controller.isFav
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.pink,
                              )
                            : const Icon(
                                Icons.favorite_border_outlined,
                              ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: SizedBox(
                    height: 50,
                    child: CustomElevatedButton(
                      text: "Book Slots",
                      borderRadius: 0,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          VenueSlotsDetails.path,
                          arguments: controller.model,
                        );
                      },
                    ),
                  ),
                  body: ListView(
                    children: [
                      Image.network(
                        controller.model.bannerImage,
                      ),
                      ListTile(
                        title: Text(
                          controller.model.name,
                          style: GoogleFonts.karla(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Text(
                          "${controller.model.openingTime} - ${controller.model.closingTime}",
                          style: GoogleFonts.karla(
                            textStyle: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(controller.model.avgRating.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 187, 184, 201),
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ListTile(
                            horizontalTitleGap: 0,
                            leading: const Icon(
                              Icons.place,
                              color: Colors.black,
                            ),
                            title: Text(
                              "Location",
                              style: GoogleFonts.ptSans(
                                textStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Text(
                              "${controller.model.location}, ${controller.model.cityName}",
                              style: GoogleFonts.ptSans(
                                textStyle: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Color.fromARGB(255, 187, 184, 201),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              "Amenities",
                              style: GoogleFonts.ptSans(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            trailing: const SizedBox.shrink(),
                            children: [
                              for (AmenityModel model in controller.amenities)
                                ListTile(
                                  title: Text(
                                    model.name,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  trailing: Image.network(
                                    model.icon,
                                    height: 30,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shadowColor: const Color.fromARGB(255, 39, 69, 85),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 187, 184, 201),
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              "Venue Rules",
                              style: GoogleFonts.ptSans(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            iconColor: Colors.black,
                            children: [
                              for (String rule
                                  in controller.model.rules.split(','))
                                ListTile(
                                  dense: true,
                                  title: Text(rule),
                                )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 187, 184, 201),
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            maintainState: true,
                            title: Text(
                              "Review and ratings (${controller.model.ratings})",
                              style: GoogleFonts.ptSans(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            trailing: TextButton(
                              child: const Text("Give feedback"),
                              onPressed: () =>
                                  ratingDialog(context, controller),
                            ),
                            iconColor: Colors.black,
                            children: [
                              for (FeedbackListingModel model
                                  in controller.feedbacks)
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(model.profilePicture),
                                  ),
                                  title: Text(model.fullName),
                                  subtitle: Text(model.review),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(model.rating.toString()),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        });
  }

  Future<dynamic> ratingDialog(
      BuildContext context, VenueDetailController controller) {
    return showDialog(
      context: context,
      builder: (context) {
        TextEditingController reviewController = TextEditingController();
        return AlertDialog(
          title: Text("Rate ${controller.model.name}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar(
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star_rounded,
                    color: Colors.yellow.shade600,
                  ),
                  half: Icon(
                    Icons.star_half_rounded,
                    color: Colors.yellow.shade600,
                  ),
                  empty: const Icon(
                    Icons.star_rounded,
                    color: Colors.grey,
                  ),
                ),
                allowHalfRating: true,
                initialRating: controller.initialRating,
                glow: true,
                glowColor: Colors.yellowAccent,
                maxRating: 5,
                minRating: 0,
                itemSize: 50,
                unratedColor: Colors.grey,
                onRatingUpdate: (value) {
                  controller.changeRating(value);
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Write a review",
                controller: reviewController,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                text: "Submit rating",
                onPressed: () async {
                  if (reviewController.text == "") {
                    Fluttertoast.showToast(
                        msg: "Please write something for us");
                  } else {
                    await controller
                        .submitRating(
                      reviewController.text,
                    )
                        .whenComplete(
                      () {
                        Navigator.pop(context);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
