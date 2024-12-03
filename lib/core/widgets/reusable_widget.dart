import 'package:flutter/material.dart';

class ReusableWidget extends StatelessWidget {
  final String label;

 // ignore: use_key_in_widget_constructors
 const ReusableWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}
