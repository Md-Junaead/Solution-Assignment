import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewmodels/web_browser_viewmodel.dart';
import '../../../bottom_sheets/grok_assistant_sheet.dart';
import '../../../core/constants/app_colors.dart';

/// Floating action bubble that appears near selected text
class SelectionActionBubble extends StatelessWidget {
  final Offset position;

  const SelectionActionBubble({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<WebBrowserViewModel>();

    return Positioned(
      left: position.dx - 30,
      top: position.dy - 80,
      child: GestureDetector(
        onTap: () {
          Get.bottomSheet(const GrokAssistantSheet());
          vm.showBubble.value = false;
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              color: AppColors.grokBlue, shape: BoxShape.circle),
          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
