import 'package:flutter/material.dart';

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_task_due_date.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_status_section.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_task_description.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_task_priority_card.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_task_title_section.dart';
import 'package:todo_ebpearls/presentation/widgets/view_task/view_task_created_at_card.dart';

class ViewTaskDetails extends StatelessWidget {
  final Task task;

  const ViewTaskDetails({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(width: 1, color: context.colorScheme.primary),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: task.isCompleted ? Colors.green.withOpacity(0.2) : context.colorScheme.outline.withOpacity(0.1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewStatusSection(isCompleted: task.isCompleted),
                const SizedBox(height: 24),
                ViewTaskTitleSection(title: task.title, isCompleted: task.isCompleted),
                if (task.description != null && task.description!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ViewTaskDescription(description: task.description!, isCompleted: task.isCompleted),
                ],
                const SizedBox(height: 28),
                Row(
                  children: [
                    ViewTaskPriorityCard(task: task),
                    const SizedBox(width: 16),
                    if (task.dueDate != null) ViewTaskDueDate(task: task) else const Expanded(child: SizedBox()),
                  ],
                ),
                const SizedBox(height: 16),
                ViewTaskCreatedAtCard(task: task),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
