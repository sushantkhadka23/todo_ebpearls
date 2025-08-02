import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_utils.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final int index;
  final VoidCallback onToggleCompletion;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.index,
    required this.onToggleCompletion,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200 + (index * 50)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
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
            child: Row(
              children: [
                GestureDetector(
                  onTap: onToggleCompletion,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted ? Colors.green : Colors.transparent,
                      border: Border.all(
                        color: task.isCompleted ? Colors.green : Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted ? const Icon(Icons.check, size: 16) : null,
                  ),
                ),
                const SizedBox(width: 16),

                // Task content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Priority indicator
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
                                Text(
                                  TaskListUtils.getPriorityText(task.priority),
                                  style: context.textTheme.labelMedium?.copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Task title
                          Expanded(
                            child: Text(
                              task.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                color: task.isCompleted ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6) : null,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      if (task.description != null && task.description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          task.description!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      const SizedBox(height: 8),

                      // Task metadata
                      Row(
                        children: [
                          if (task.dueDate != null) ...[
                            FaIcon(
                              FontAwesomeIcons.calendar,
                              size: 12,
                              color: TaskListUtils.isDueDateOverdue(task.dueDate!)
                                  ? Colors.red.shade400
                                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              TaskListUtils.formatDueDate(task.dueDate!),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: TaskListUtils.isDueDateOverdue(task.dueDate!)
                                    ? Colors.red.shade400
                                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],

                          FaIcon(
                            FontAwesomeIcons.clock,
                            size: 12,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            TaskListUtils.formatCreatedAt(task.createdAt),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Action buttons
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'view':
                        onView();
                        break;
                      case 'edit':
                        onEdit();
                        break;
                      case 'delete':
                        onDelete();
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'view',
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.eye, size: 16, color: context.colorScheme.onSurface),
                          const SizedBox(width: 12),
                          const Text('View'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.edit, color: context.colorScheme.onSurface, size: 16),
                          const SizedBox(width: 12),
                          const Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.trash, size: 16, color: Colors.red),
                          const SizedBox(width: 12),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
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
