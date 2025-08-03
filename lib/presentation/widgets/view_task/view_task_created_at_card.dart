import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_utils.dart';

class ViewTaskCreatedAtCard extends StatelessWidget {
  final Task task;

  const ViewTaskCreatedAtCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final formattedCreatedAt = TaskListUtils.formatCreatedAt(task.createdAt);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: context.colorScheme.secondary, borderRadius: BorderRadius.circular(8)),
            child: FaIcon(FontAwesomeIcons.clock, size: 12, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Created At',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                formattedCreatedAt,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
