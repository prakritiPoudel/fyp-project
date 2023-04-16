import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty_waysfluttedo/utils/constants.dart';

import '../../controller/homepage_category_controller.dart';
import '../../model/category_model.dart';
import 'view_by.dart';

class HomepageCategories extends StatelessWidget {
  const HomepageCategories({
    super.key,
    required HomepageCategoriesController homepageCategoriesController,
  }) : _homepageCategoriesController = homepageCategoriesController;

  final HomepageCategoriesController _homepageCategoriesController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageCategoriesController>(
        init: _homepageCategoriesController,
        builder: (controller) {
          return controller.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: 120,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 15);
                    },
                    itemCount: controller.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      CategoryModel model = controller.categories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ViewBy.path,
                            arguments: ViewByModel(
                              query: "category",
                              value: controller.categories[index].id.toString(),
                              title:
                                  "Venues for ${controller.categories[index].name}",
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                shape: const CircleBorder(),
                                elevation: 14.0,
                                shadowColor: shColor,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    model.icon,
                                  ),
                                ),
                              ),
                              Text(
                                model.name,
                                style: GoogleFonts.ptSans(
                                    textStyle: const TextStyle(fontSize: 13)),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        });
  }
}
