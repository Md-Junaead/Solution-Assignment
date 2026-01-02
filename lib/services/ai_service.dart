import 'dart:async';
import '../../core/constants/app_strings.dart';

/// Service handling AI prompt processing
/// Currently returns demo responses – replace with real Grok API later
class AIService {
  // Singleton instance
  static final AIService _instance = AIService._internal();
  factory AIService() => _instance;
  AIService._internal();

  /// Generates demo AI response based on prompt and selected text
  Future<String> processPrompt(String selectedText, String prompt) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    final String lowerPrompt = prompt.toLowerCase();

    if (lowerPrompt.contains('improve') ||
        lowerPrompt.contains(AppStrings.improveWriting.toLowerCase())) {
      return 'Improved version:\n\n${selectedText.split(' ').take(20).join(' ')}... (made clearer and more concise).';
    } else if (lowerPrompt.contains('summarize') ||
        lowerPrompt.contains('summary')) {
      return 'Summary:\n\n${selectedText.split(' ').take(15).join(' ')}...';
    } else if (lowerPrompt.contains('rewrite')) {
      return 'Rewritten:\n\n${selectedText.split(' ').reversed.take(18).join(' ')}...';
    } else if (lowerPrompt.contains('simplify')) {
      return 'Simplified:\n\n${selectedText.toLowerCase().split(' ').take(20).join(' ')}...';
    } else if (lowerPrompt.contains('plagiarism')) {
      return 'Plagiarism Check: No issues detected (demo).';
    } else {
      // Custom prompt fallback
      return 'AI Response for: "$prompt"\n\nOriginal text:\n$selectedText\n\nProcessed output based on your instruction.';
    }
  }
}
