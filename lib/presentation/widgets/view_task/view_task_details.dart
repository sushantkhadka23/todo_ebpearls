import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_utils.dart';

class ViewTaskDetails extends StatelessWidget {
  final Task task;

  const ViewTaskDetails({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
          gradient: task.isCompleted
              ? LinearGradient(colors: [Colors.green.withOpacity(0.07), Colors.green.withOpacity(0.07)])
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted ? Colors.green : Colors.transparent,
                      border: Border.all(
                        color: task.isCompleted ? Colors.green : Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : const Icon(Icons.circle, size: 16, color: Colors.transparent),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    task.isCompleted ? 'Completed' : 'Active',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: task.isCompleted ? Colors.green : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                task.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              if (task.description != null && task.description!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  task.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              // Priority
              Row(
                children: [
                  Text('Priority:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      color: _getLightPriorityColor(task.priority),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: TaskListUtils.getPriorityColor(task.priority), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: TaskListUtils.getPriorityColor(task.priority).withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        FaIcon(TaskListUtils.getPriorityIcon(task.priority), size: 12, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(TaskListUtils.getPriorityText(task.priority), style: context.textTheme.labelMedium),
                      ],
                    ),
                  ),
                ],
              ),
              if (task.dueDate != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('Due Date:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    FaIcon(
                      FontAwesomeIcons.calendar,
                      size: 14,
                      color: TaskListUtils.isDueDateOverdue(task.dueDate!)
                          ? Colors.red.shade400
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      TaskListUtils.formatDueDate(task.dueDate!),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: TaskListUtils.isDueDateOverdue(task.dueDate!)
                            ? Colors.red.shade400
                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              // Created At
              Row(
                children: [
                  Text('Created:', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  FaIcon(FontAwesomeIcons.clock, size: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                  const SizedBox(width: 4),
                  Text(
                    TaskListUtils.formatCreatedAt(task.createdAt),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLightPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red.shade200;
      case Priority.medium:
        return Colors.orange.shade200;
      case Priority.low:
        return Colors.green.shade200;
    }
  }
}
