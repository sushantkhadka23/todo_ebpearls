import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_utils.dart';

class ViewTaskPriorityCard extends StatelessWidget {
  final Task task;
  const ViewTaskPriorityCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final priorityColor = TaskListUtils.getPriorityColor(task.priority);
    final priorityIcon = TaskListUtils.getPriorityIcon(task.priority);
    final priorityText = TaskListUtils.getPriorityText(task.priority);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: priorityColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: priorityColor.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: priorityColor, borderRadius: BorderRadius.circular(8)),
                  child: FaIcon(priorityIcon, size: 12, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  'Priority',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              priorityText,
              style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: priorityColor),
            ),
          ],
        ),
      ),
    );
  }
}
