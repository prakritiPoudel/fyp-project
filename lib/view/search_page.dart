import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/search_controller.dart';
import '../model/venue_listing_model.dart';
import 'details_page/detail_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  static const String path = '/search';
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              autofocus: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onChanged: (String query) {
                controller.loadVenues(query);
              },
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                isCollapsed: true,
                hintText: "Type here to search for venues",
                hintStyle: TextStyle(fontSize: 12),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: ListView.separated(
            separatorBuilder: (c, i) => const SizedBox(height: 10),
            itemCount: controller.searchResult.length,
            itemBuilder: (context, index) {
              final VenueListingModel model = controller.searchResult[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(DetailsPage.path, arguments: model.id);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            model.bannerImage,
                            height: 80,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Text(
                                model.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(model.location),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 12,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(model.avgRating.toString()),
                                ],
                              ),
                              const Spacer(),
                            ],
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
      },
    );
  }
}
