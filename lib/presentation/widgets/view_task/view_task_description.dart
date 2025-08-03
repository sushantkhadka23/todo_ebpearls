import 'package:flutter/material.dart';

import 'package:todo_ebpearls/core/extension/theme_extension.dart';

class ViewTaskDescription extends StatelessWidget {
  final String description;
  final bool isCompleted;

  const ViewTaskDescription({super.key, required this.description, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colorScheme.outline.withOpacity(0.1)),
          ),
          child: Text(
            description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.8),
              height: 1.5,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
              decorationColor: context.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
