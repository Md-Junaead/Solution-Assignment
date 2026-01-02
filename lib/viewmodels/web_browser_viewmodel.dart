import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import '../../services/ai_service.dart';
import '../../core/constants/app_strings.dart';

/// Core ViewModel managing the entire text selection → AI flow
class WebBrowserViewModel extends GetxController {
  final AIService _aiService = AIService();

  // Reactive states
  final RxString selectedText = ''.obs;
  final RxString activePrompt = ''.obs;
  final RxString aiResult = ''.obs;
  final Rx<Offset?> bubblePosition = Rx<Offset?>(null);
  final RxBool showBubble = false.obs;
  final RxBool isProcessing = false.obs;

  // Floating action chip state
  final RxString currentActionText = ''.obs;
  final RxBool showActionChip = false.obs;

  // Pre-built prompts
  final List<String> prebuiltPrompts = [
    AppStrings.improveWriting,
    AppStrings.summarize,
    AppStrings.rewrite,
    AppStrings.simplify,
    AppStrings.plagiarismCheck,
  ];

  void onTextSelected(String text, Offset position) {
    if (text.trim().isNotEmpty) {
      selectedText.value = text.trim();
      bubblePosition.value = position;
      showBubble.value = true;
    }
  }

  void clearSelection() {
    selectedText.value = '';
    activePrompt.value = '';
    aiResult.value = '';
    showBubble.value = false;
    bubblePosition.value = null;
    hideActionChip();
  }

  /// Synchronous entry point for UI buttons
  /// Safe to use with VoidCallback
  void applyPrompt(String prompt) {
    if (selectedText.value.isEmpty || isProcessing.value) return;

    // Update UI state immediately
    currentActionText.value = prompt;
    showActionChip.value = true;
    activePrompt.value = prompt;
    isProcessing.value = true;

    // Close bottom sheet
    if (Get.isBottomSheetOpen!) Get.back();

    // Fire-and-forget async processing
    _runAiProcessing(prompt);
  }

  /// Private async method – does the actual AI call
  Future<void> _runAiProcessing(String prompt) async {
    try {
      final result = await _aiService.processPrompt(selectedText.value, prompt);
      aiResult.value = result;
    } catch (e) {
      aiResult.value = 'Error processing request. Please try again.';
      Get.snackbar('Error', 'AI processing failed');
    } finally {
      isProcessing.value = false;
    }
  }

  void copyResult() {
    if (aiResult.value.isNotEmpty) {
      FlutterClipboard.copy(aiResult.value).then((_) {
        Get.snackbar('Copied', AppStrings.copied,
            duration: const Duration(seconds: 2));
      });
    }
  }

  void clearActivePrompt() {
    activePrompt.value = '';
    aiResult.value = '';
  }

  void hideActionChip() {
    showActionChip.value = false;
    currentActionText.value = '';
  }
}
