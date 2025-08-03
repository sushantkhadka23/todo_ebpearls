import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/core/utils/todo_utils.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final padding = screenWidth * 0.04;
    final iconSize = isSmallScreen ? 10.0 : 12.0;
    final fontSize = isSmallScreen ? 10.0 : 12.0;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200 + (index * 50)),
      margin: EdgeInsets.only(bottom: padding * 0.75),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(padding)),
        color: Theme.of(context).colorScheme.surface,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(padding),
            border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
            gradient: task.isCompleted
                ? LinearGradient(colors: [Colors.green.withOpacity(0.07), Colors.green.withOpacity(0.07)])
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox
                GestureDetector(
                  onTap: onToggleCompletion,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: padding * 1.5, // Adjusted from 24
                    height: padding * 1.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted ? Colors.green : Colors.transparent,
                      border: Border.all(
                        color: task.isCompleted ? Colors.green : Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted ? Icon(Icons.check, size: padding) : null,
                  ),
                ),
                SizedBox(width: padding),

                // Task content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Priority indicator
                          Container(
                            padding: EdgeInsets.symmetric(vertical: padding * 0.375, horizontal: padding * 0.625),
                            decoration: BoxDecoration(
                              color: TodoUtils.getPriorityColor(task.priority),
                              borderRadius: BorderRadius.circular(padding),
                              border: Border.all(color: TodoUtils.getPriorityColor(task.priority), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: TodoUtils.getPriorityColor(task.priority).withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              TodoUtils.getPriorityText(task.priority),
                              style: context.textTheme.labelMedium?.copyWith(color: Colors.black, fontSize: fontSize),
                            ),
                          ),
                          SizedBox(width: padding * 0.5),

                          // Task title
                          Flexible(
                            child: Text(
                              task.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                color: task.isCompleted ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6) : null,
                                fontWeight: FontWeight.w600,
                                fontSize: isSmallScreen ? 14.0 : 16.0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      if (task.description != null && task.description!.isNotEmpty) ...[
                        SizedBox(height: padding * 0.25),
                        Text(
                          task.description!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                            fontSize: fontSize,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      SizedBox(height: padding * 0.5),

                      // Task metadata
                      Wrap(
                        spacing: padding * 0.75,
                        runSpacing: 4,
                        children: [
                          if (task.dueDate != null) ...[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.calendar,
                                  size: iconSize,
                                  color: TodoUtils.isDueDateOverdue(task.dueDate!)
                                      ? Colors.red.shade400
                                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                ),
                                SizedBox(width: padding * 0.25),
                                Text(
                                  TodoUtils.formatDueDate(task.dueDate!),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: TodoUtils.isDueDateOverdue(task.dueDate!)
                                        ? Colors.red.shade400
                                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                    fontSize: fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.clock,
                                size: iconSize,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              ),
                              SizedBox(width: padding * 0.25),
                              Text(
                                TodoUtils.formatCreatedAt(task.createdAt),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  fontSize: fontSize,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(width: padding * 0.75),

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
                          FaIcon(FontAwesomeIcons.eye, size: iconSize, color: context.colorScheme.onSurface),
                          SizedBox(width: padding * 0.75),
                          Text('View', style: TextStyle(fontSize: fontSize)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.edit, color: context.colorScheme.onSurface, size: iconSize),
                          SizedBox(width: padding * 0.75),
                          Text('Edit', style: TextStyle(fontSize: fontSize)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.trash, size: iconSize, color: Colors.red),
                          SizedBox(width: padding * 0.75),
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.red, fontSize: fontSize),
                          ),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    padding: EdgeInsets.all(padding * 0.5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(padding * 0.5),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: iconSize,
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
}
