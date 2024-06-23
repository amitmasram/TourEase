import 'package:flutter/material.dart';
import 'package:concentric_transition/page_view.dart';
import 'package:vtg_app/data/models/onboarding_contents.dart';
import 'package:vtg_app/views/authentication/home_auth_screen.dart';
import 'package:vtg_app/views/widgets/onboarding_widget.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        itemBuilder: (index) {
          final page = contents[index % contents.length];
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SafeArea(child: MainPageWidget(page: page)),
          );
        },
        nextButtonBuilder: (context) => const Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
        colors: const [
          Color.fromARGB(255, 246, 246, 246),
          Color.fromARGB(255, 255, 210, 74),
          Colors.greenAccent
          // Color.fromARGB(255, 14, 238, 178)
        ],
        onFinish: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeAuthScreen()));
        },
      ),
    );
  }
}
