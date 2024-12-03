import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final bool obscureText;
  final VoidCallback? onIconPressed; // Add this callback for the icon press

  const CustomTextField({
    super.key,
    this.icon,
    required this.hintText,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.onIconPressed, // Initialize it in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: AppTextStyles.bodyText),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.bodyText,
            suffixIcon: icon == null
                ? null
                : IconButton(
                    icon: Icon(icon),
                    onPressed: onIconPressed,  // Trigger the callback
                  ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
