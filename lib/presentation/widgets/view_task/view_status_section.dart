import 'package:flutter/material.dart';

import 'package:todo_ebpearls/core/extension/theme_extension.dart';

class ViewStatusSection extends StatelessWidget {
  final bool isCompleted;

  const ViewStatusSection({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isCompleted ? Colors.green.withOpacity(0.1) : context.colorScheme.primaryContainer.withOpacity(0.3),
        border: Border.all(
          color: isCompleted ? Colors.green.withOpacity(0.3) : context.colorScheme.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? Colors.green : Colors.transparent,
              border: Border.all(color: isCompleted ? Colors.green : context.colorScheme.primary, width: 2),
            ),
            child: isCompleted
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : Icon(Icons.circle_outlined, size: 14, color: context.colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Text(
            isCompleted ? 'Completed' : 'In Progress',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isCompleted ? Colors.green.shade700 : context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
