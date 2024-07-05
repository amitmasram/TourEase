import 'package:TourEase/core/constants/text_strings.dart';
import 'package:TourEase/core/utils/network_images.dart';
import 'package:TourEase/core/utils/responsive.dart';
import 'package:TourEase/core/utils/text_styles.dart';
import 'package:TourEase/view/main_screen/home/carousal_slider.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/colors.dart';
import '../../../core/helpers/helper.dart';
import '../../../data/models/location_dummy.dart';
import 'location_based_data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final List<String> dummyData = List.generate(20, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      appBar: AppBar(
        title: Text(
          AppStrings.appName,
          style: AppTextStyles.bodyText2,
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Row(
              children: [
                Container(
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.bell,
                    size: 28,
                  )),
                ),
                SizedBox(
                  width: Responsive.screenWidth(context) * 0.06,
                ),
                Container(
                  height: 36, // Adjusted height to make it fit more snugly
                  width: 36, // Adjusted width to make it fit more snugly
                  padding: const EdgeInsets.all(
                      2), // Reduced padding to decrease thickness
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.grey.shade300)],
                    gradient: GradientColors.gradient,
                  ),
                  child: const CircleAvatar(
                    radius: 20, // Kept radius same as original
                    backgroundImage: NetworkImage(NetworkImages.profilePic),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                cursorColor: dark ? AppColors.white : AppColors.darkGrey,
                decoration: InputDecoration(
                  hintText: 'Search for places',
                  focusColor: AppColors.primary,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: FaIcon(
                      // ignore: deprecated_member_use
                      FontAwesomeIcons.search,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.amber), // Set the default border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: AppColors
                            .primary), // Set the border color when focused
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Trending Places',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            // ignore: sized_box_for_whitespace
            Container(height: 230, child: const CarouselChangeReasonDemo()),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Places',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(
                      color: Color.fromARGB(255, 235, 193, 66),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.black,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                            child: Image.asset(
                              locations[index].image,
                              height: 200, // Decreased height
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3), // Adjusted padding
                            title: Text(
                              locations[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  locations[index].district,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const Text(
                                  ',',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  locations[index].state,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 1), // Adjusted padding
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ignore: avoid_unnecessary_containers
                                Container(
                                  child: const FaIcon(
                                    FontAwesomeIcons.locationDot,
                                    color: Colors.amber,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10, // Decreased width
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          location: locations[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.arrowUpRightFromSquare,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        " Get to Know more",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
