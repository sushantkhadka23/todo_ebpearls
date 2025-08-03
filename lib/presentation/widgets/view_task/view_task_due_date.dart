import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_utils.dart';

class ViewTaskDueDate extends StatelessWidget {
  final Task task;

  const ViewTaskDueDate({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isOverdue = TaskListUtils.isDueDateOverdue(task.dueDate!);
    final formattedDate = TaskListUtils.formatDueDate(task.dueDate!);
    final dueDateColor = isOverdue ? Colors.red.shade400 : context.colorScheme.primary;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: dueDateColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: dueDateColor.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: dueDateColor, borderRadius: BorderRadius.circular(8)),
                  child: FaIcon(FontAwesomeIcons.calendar, size: 12, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  isOverdue ? 'Overdue' : 'Due Date',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              formattedDate,
              style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: dueDateColor),
            ),
          ],
        ),
      ),
    );
  }
}
