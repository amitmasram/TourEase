import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtg_app/models/travel_dummy.dart';
import 'package:vtg_app/views/main_screen/home/carousal_slider.dart';
import 'package:vtg_app/views/main_screen/home/location_based_data_screen.dart';

import '../../../models/location_dummy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final List<String> dummyData = List.generate(20, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth
                  .instance.currentUser!.uid) // Assuming user is logged in
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                'Welcome',
                style:
                    GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
              );
            } else {
              if (snapshot.hasError) {
                return Text(
                  'Welcome',
                  style: GoogleFonts.lato(
                      fontSize: 24, fontWeight: FontWeight.bold),
                );
              } else {
                var userData = snapshot.data!.data() as Map<String, dynamic>;
                String userName = userData['name'];
                return Text(
                  'Welcome\n$userName',
                  style: GoogleFonts.lato(
                      fontSize: 24, fontWeight: FontWeight.bold),
                );
              }
            }
          },
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Container(
              height: 35,
              width: 35,
              child: const Center(child: FaIcon(FontAwesomeIcons.bell)),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
            ),
          )
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
                decoration: InputDecoration(
                  hintText: 'Search for places',
                  hoverColor: Colors.amber,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: FaIcon(
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
                        color:
                            Colors.amber), // Set the border color when focused
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
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
                                Container(
                                  child: const FaIcon(
                                    FontAwesomeIcons.locationArrow,
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
                                        color: Colors.greenAccent,
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


//  Expanded(
//               child: ListView.builder(
//                 itemCount: dummyData.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     leading: Image.asset(
//                       dummyData[index].image,
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                     ),
//                     title: Text(dummyData[index].location),
//                     subtitle: Text(dummyData[index].description),
//                   );
//                 },
//               ),
//             ),