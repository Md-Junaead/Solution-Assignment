import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import '../../services/ai_service.dart';
import '../../core/constants/app_strings.dart';

/// Core ViewModel managing the entire text selection → AI flow
/// Uses reactive state (GetX) for bubble visibility, selected text, result, etc.
class WebBrowserViewModel extends GetxController {
  final AIService _aiService = AIService();

  // Reactive states
  final RxString selectedText = ''.obs;
  final RxString activePrompt = ''.obs;
  final RxString aiResult = ''.obs;
  final Rx<Offset?> bubblePosition = Rx<Offset?>(null);
  final RxBool showBubble = false.obs;
  final RxBool isProcessing = false.obs;

  // Pre-built prompts list
  final List<String> prebuiltPrompts = [
    AppStrings.improveWriting,
    AppStrings.summarize,
    AppStrings.rewrite,
    AppStrings.simplify,
    AppStrings.plagiarismCheck,
  ];

  /// Called when text is selected via JS
  void onTextSelected(String text, Offset position) {
    if (text.trim().isNotEmpty) {
      selectedText.value = text.trim();
      bubblePosition.value = position;
      showBubble.value = true;
    }
  }

  /// Clear all selection state
  void clearSelection() {
    selectedText.value = '';
    activePrompt.value = '';
    aiResult.value = '';
    showBubble.value = false;
    bubblePosition.value = null;
  }

  /// Apply a prompt (pre-built or custom)
  Future<void> applyPrompt(String prompt) async {
    if (selectedText.value.isEmpty) return;

    activePrompt.value = prompt;
    isProcessing.value = true;

    try {
      final result = await _aiService.processPrompt(selectedText.value, prompt);
      aiResult.value = result;
    } catch (e) {
      aiResult.value = 'Error processing request. Please try again.';
    } finally {
      isProcessing.value = false;
    }
  }

  /// Copy AI result to clipboard
  void copyResult() {
    if (aiResult.value.isNotEmpty) {
      FlutterClipboard.copy(aiResult.value).then((_) {
        Get.snackbar('Copied', AppStrings.copied, duration: const Duration(seconds: 2));
      });
    }
  }

  /// Remove active prompt chip
  void clearActivePrompt() {
    activePrompt.value = '';
    aiResult.value = '';
  }
}