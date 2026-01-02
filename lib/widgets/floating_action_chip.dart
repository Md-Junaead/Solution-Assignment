import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../viewmodels/web_browser_viewmodel.dart';

/// Reusable floating chip shown at top after any prompt action
/// Displays "[Action] Clicked ×" – exact match to screenshot
/// Auto-dismisses after 4 seconds or on × tap
class FloatingActionChip extends StatelessWidget {
  const FloatingActionChip({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<WebBrowserViewModel>();

    // Auto-dismiss after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (vm.showActionChip.value) {
        vm.hideActionChip();
      }
    });

    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
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
                  Obx(() => Text(
                        '${vm.currentActionText.value} Clicked',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColors.primaryText,
                        ),
                      )),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: vm.hideActionChip,
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: AppColors.primaryText,
                    ),
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
