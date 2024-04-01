import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vtg_app/firebase_options.dart';
import 'views/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const VTG());
}

class VTG extends StatelessWidget {
  const VTG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Onboarding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const Onboarding(),
    );
  }
}
