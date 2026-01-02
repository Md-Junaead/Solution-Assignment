import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Reusable text field for custom prompt input
class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function(String)? onSubmitted;

  const CustomTextField({super.key, required this.hintText, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.send,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.scaffoldBackground,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        suffixIcon: const Icon(Icons.send, color: AppColors.grokBlue),
      ),
    );
  }
}
