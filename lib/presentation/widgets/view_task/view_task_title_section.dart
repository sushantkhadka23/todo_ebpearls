import 'package:flutter/material.dart';

import 'package:todo_ebpearls/core/extension/theme_extension.dart';

class ViewTaskTitleSection extends StatelessWidget {
  final String title;
  final bool isCompleted;

  const ViewTaskTitleSection({super.key, required this.title, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Title',
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: context.colorScheme.onSurface.withOpacity(0.5),
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
