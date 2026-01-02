import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/web_browser_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/action_button.dart';
import '../widgets/result_display.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';

/// Bottom sheet with full AI assistant functionality
class GrokAssistantSheet extends StatelessWidget {
  const GrokAssistantSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<WebBrowserViewModel>();

    return WillPopScope(
      onWillPop: () async {
        vm.clearSelection();
        return true;
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Obx(() => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: AppStrings.customPromptHint,
                    onSubmitted: (v) {
                      if (v.isNotEmpty) vm.applyPrompt(v);
                    },
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: vm.prebuiltPrompts.map((p) {
                      final bool isCurrent = p == vm.activePrompt.value;
                      final bool isLoading = vm.isProcessing.value;

                      return Opacity(
                        opacity: isLoading && isCurrent ? 0.6 : 1.0,
                        child: ActionButton(
                          label: p,
                          icon: isLoading && isCurrent
                              ? Icons.hourglass_bottom
                              : Icons.smart_button,
                          // Fixed: onTap can be null – no error
                          onTap: isLoading ? null : () => vm.applyPrompt(p),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Get.snackbar(
                              'Insert', 'Insert feature coming soon (demo)'),
                          icon: const Icon(Icons.arrow_downward,
                              color: Colors.white),
                          label: const Text('Insert',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.grokBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Get.snackbar(
                              'Replace', 'Replace feature coming soon (demo)'),
                          icon: const Icon(Icons.swap_horiz,
                              color: AppColors.grokBlue),
                          label: const Text('Replace',
                              style: TextStyle(color: AppColors.grokBlue)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(
                                color: AppColors.grokBlue, width: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (vm.isProcessing.value)
                    const Center(child: CircularProgressIndicator())
                  else if (vm.aiResult.value.isNotEmpty)
                    ResultDisplay(
                        result: vm.aiResult.value, onCopy: vm.copyResult),
                  const SizedBox(height: 40),
                ],
              ),
            )),
      ),
    );
  }
}
