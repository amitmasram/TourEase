// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import '../../../../core/constants/colors.dart';
// import '../../../../core/helpers/helper.dart';

// class AllScreen extends StatelessWidget {
//   const AllScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Scaffold(
//       backgroundColor: dark ? AppColors.dark : AppColors.light,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 16, right: 16),
//           child: MasonryGridView.count(
//             physics: const BouncingScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             crossAxisCount: 2,
//             mainAxisSpacing: 16,
//             crossAxisSpacing: 16,
//             itemCount: 20,
//             itemBuilder: (context, index) {
//               return Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(15),
//                       ),
//                       child: Image.asset(
//                         'assets/images/travel.png',
//                         height: (index.isEven) ? 120 : 180,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         "Gorewada ",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text("This is a description of the item."),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import '../../../../core/constants/colors.dart';
// import '../../../../core/helpers/helper.dart';
// import '../../../../data/models/travel_dummy.dart';

// class AllScreen extends StatelessWidget {
//   const AllScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     return Scaffold(
//       backgroundColor: dark ? AppColors.dark : AppColors.light,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Discover Amazing Places',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: dark ? Colors.white : Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: MasonryGridView.count(
//                   physics: const BouncingScrollPhysics(),
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 16,
//                   crossAxisSpacing: 16,
//                   itemCount: dummyData.length,
//                   itemBuilder: (context, index) {
//                     return _buildDestinationCard(dummyData[index], dark);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDestinationCard(TravelDestination destination, bool dark) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       color: dark ? Colors.grey[800] : Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//             child: Image.network(
//               destination.image,
//               height: 150,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   height: 150,
//                   color: Colors.grey,
//                   child: const Icon(Icons.error),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   destination.location,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: dark ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   destination.description,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: dark ? Colors.white70 : Colors.black87,
//                   ),
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:TourEase/data/models/location_dummy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/helpers/helper.dart';
 // Assuming location_model contains the 'Location' model

class AllScreen extends StatelessWidget {
  const AllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover Amazing Places',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: dark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: MasonryGridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemCount: locations.length, // Using 'locations' from the Location model
                  itemBuilder: (context, index) {
                    return _buildLocationCard(locations[index], dark);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard(Location location, bool dark) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: dark ? Colors.grey[800] : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              location.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey,
                  child: const Icon(Icons.error),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: dark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location.locality,
                  style: TextStyle(
                    fontSize: 14,
                    color: dark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
