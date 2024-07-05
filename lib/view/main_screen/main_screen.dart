import 'package:TourEase/core/constants/colors.dart';
import 'package:TourEase/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home/home_screen.dart';
import 'location/geo_location.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    GeoLocation(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _screens[_currentIndex]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                width: Responsive.screenWidth(context) * 0.8,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: GradientColors.gradient,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.locationArrow),
                        label: 'Location',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.user),
                        label: 'Profile',
                      ),
                    ],
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    type: BottomNavigationBarType.fixed,
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
