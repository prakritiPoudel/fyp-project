import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sporty_waysfluttedo/utils/constants.dart';

import '../../controller/homepage_banners_controller.dart';
import '../../model/banner_model.dart';

class TopSliders extends StatefulWidget {
  const TopSliders({
    super.key,
    required HomepageBannerController homepageBannerController,
  }) : _homepageBannerController = homepageBannerController;

  final HomepageBannerController _homepageBannerController;

  @override
  State<TopSliders> createState() => _TopSlidersState();
}

class _TopSlidersState extends State<TopSliders> {
  int _activeindex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageBannerController>(
      init: widget._homepageBannerController,
      builder: (controller) {
        return controller.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: 188,
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            _activeindex = index;
                          });
                        },
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        // aspectRatio: 16 / 9,
                        enlargeFactor: 0.7,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        height: 150,
                      ),
                      itemCount: controller.banners.length,
                      itemBuilder: (ctx, index, realIdx) {
                        BannerModel model = controller.banners[index];
                        return Stack(
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 1.0,
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Card(
                                elevation: 5.0,
                                shadowColor:
                                    const Color.fromARGB(255, 143, 196, 238),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    model.banner,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              left: 10,
                              child: SizedBox(
                                height: 80,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.2),
                                      child: Text(
                                        cTitles[index],
                                        style: GoogleFonts.karla(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      csubTitles[index],
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.ptSerif(
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99.0),
                        child: AnimatedSmoothIndicator(
                          activeIndex: _activeindex,
                          count: controller.banners.length,
                          effect: CustomizableEffect(
                            activeDotDecoration: DotDecoration(
                              width: 32,
                              height: 12,
                              color: const Color.fromARGB(255, 36, 63, 215),
                              rotationAngle: 180,
                              verticalOffset: -10,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            dotDecoration: DotDecoration(
                              height: 12,
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16),
                              verticalOffset: 0,
                            ),
                            spacing: 6.0,
                            inActiveColorOverride: (i) => colors[i],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
