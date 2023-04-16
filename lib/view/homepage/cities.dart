import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/homepage_city_controller.dart';
import '../../utils/constants.dart';
import 'view_by.dart';

class HomepageCities extends StatelessWidget {
  const HomepageCities({
    super.key,
    required HomepageCityController homepageCityController,
  }) : _homepageCityController = homepageCityController;

  final HomepageCityController _homepageCityController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: GetBuilder<HomepageCityController>(
          init: _homepageCityController,
          builder: (controller) {
            return controller.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 15);
                    },
                    itemCount: controller.cities.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ViewBy.path,
                            arguments: ViewByModel(
                              query: "city",
                              value: controller.cities[index].id.toString(),
                              title:
                                  "Venues in ${controller.cities[index].name}",
                            ),
                          );
                        },
                        child: Material(
                          child: Chip(
                            elevation:
                                7, // set the elevation of the Material widgetborderRadius: BorderRadius.circular(10),
                            backgroundColor: primaryColor.withOpacity(0.2),
                            label: Text(
                              controller.cities[index].name,
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
