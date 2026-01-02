import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';

/// Reusable widget to display AI result
class ResultDisplay extends StatelessWidget {
  final String result;
  final VoidCallback onCopy;

  const ResultDisplay({super.key, required this.result, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Result:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grokBlue),
              borderRadius: BorderRadius.circular(12)),
          child: SelectableText(result, style: const TextStyle(height: 1.5)),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
            icon: const Icon(Icons.copy),
            label: const Text(AppStrings.copyResult),
            onPressed: onCopy),
      ],
    );
  }
}
