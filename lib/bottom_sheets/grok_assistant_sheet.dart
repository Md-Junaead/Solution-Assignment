import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/web_browser_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/action_button.dart';
import '../widgets/result_display.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/extensions.dart'; // For truncate()

/// Bottom sheet with full AI assistant functionality
/// Now includes Insert (blue filled) & Replace (outlined) buttons
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

                  // Custom prompt input at top
                  CustomTextField(
                    hintText: AppStrings.customPromptHint,
                    onSubmitted: (v) => v.isNotEmpty ? vm.applyPrompt(v) : null,
                  ),

                  const SizedBox(height: 20),

                  // Pre-built prompt buttons
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: vm.prebuiltPrompts.map((p) {
                      return ActionButton(
                        label: p,
                        icon: Icons.smart_button,
                        onTap: () => vm.applyPrompt(p),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // NEW: Insert & Replace buttons (special design)
                  Row(
                    children: [
                      // Insert Button – Blue filled
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Demo action – can be extended later
                            Get.snackbar(
                                'Insert', 'Insert feature coming soon (demo)');
                          },
                          icon: const Icon(Icons.arrow_downward,
                              color: Colors.white),
                          label: const Text('Insert',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.grokBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Replace Button – Outlined (natural look)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Demo action – can be extended later
                            Get.snackbar('Replace',
                                'Replace feature coming soon (demo)');
                          },
                          icon: const Icon(Icons.swap_horiz,
                              color: AppColors.grokBlue),
                          label: Text('Replace',
                              style: TextStyle(color: AppColors.grokBlue)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(
                                color: AppColors.grokBlue, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Active prompt chip with ×
                  if (vm.activePrompt.value.isNotEmpty)
                    Chip(
                      label: Text(vm.activePrompt.value),
                      backgroundColor: AppColors.grokBlue.withOpacity(0.1),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: vm.clearActivePrompt,
                    ),

                  const SizedBox(height: 16),

                  // Processing or Result
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
