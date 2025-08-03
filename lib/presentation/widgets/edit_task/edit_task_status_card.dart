import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';
import 'package:todo_ebpearls/domain/entity/task.dart';

class EditTaskStatusCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleCompletion;

  const EditTaskStatusCard({super.key, required this.task, required this.onToggleCompletion});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: task.isCompleted ? Colors.green.shade50 : Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: task.isCompleted ? Colors.green.shade200 : Colors.amber.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: task.isCompleted ? Colors.green.shade100 : Colors.amber.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(
              task.isCompleted ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.clock,
              color: task.isCompleted ? Colors.green.shade600 : Colors.amber.shade600,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.isCompleted ? 'Completed Task' : 'Active Task',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: task.isCompleted ? Colors.green.shade700 : Colors.amber.shade500,
                  ),
                ),
                Text(
                  'Created on ${DateFormat('MMM dd, yyyy').format(task.createdAt)}',
                  style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onToggleCompletion,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: task.isCompleted ? Colors.amber.shade100 : Colors.green.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                task.isCompleted ? 'Mark Active' : 'Mark Done',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: task.isCompleted ? Colors.amber.shade700 : Colors.green.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
