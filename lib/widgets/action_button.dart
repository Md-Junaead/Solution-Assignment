import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Reusable button for pre-built prompts
class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grokBlue),
              borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 18, color: AppColors.grokBlue),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: AppColors.grokBlue, fontWeight: FontWeight.w500)),
          ]),
        ),
      ),
    );
  }
}
