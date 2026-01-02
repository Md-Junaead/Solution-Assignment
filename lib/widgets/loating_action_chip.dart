import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';

/// Reusable floating chip that appears at the top after an action
/// Shows "[Action] Clicked ×" – matches screenshot exactly
/// Auto-dismisses after 4 seconds or on × tap
class FloatingActionChip extends StatelessWidget {
  final String actionText;

  const FloatingActionChip({super.key, required this.actionText});

  @override
  Widget build(BuildContext context) {
    // Auto-dismiss after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (Get.isSnackbarOpen || Get.isDialogOpen!) return;
      Get.closeCurrentSnackbar(); // In case it's shown as snackbar internally
    });

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$actionText Clicked',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Get.back(), // Close the chip
                    child: const Icon(Icons.close,
                        size: 20, color: AppColors.primaryText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
