import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';

class TodoUtils {
  static Color getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red.shade400;
      case Priority.medium:
        return Colors.orange.shade400;
      case Priority.low:
        return Colors.green.shade400;
    }
  }

  static IconData getPriorityIcon(Priority priority) {
    switch (priority) {
      case Priority.high:
        return FontAwesomeIcons.exclamation;
      case Priority.medium:
        return FontAwesomeIcons.minus;
      case Priority.low:
        return FontAwesomeIcons.arrowDown;
    }
  }

  static String getPriorityText(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
    }
  }

  // Date-related methods
  static String getDueDateRelativeText(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final difference = due.difference(today).inDays;

    if (difference == 0) {
      return 'Due today';
    } else if (difference == 1) {
      return 'Due tomorrow';
    } else if (difference == -1) {
      return 'Due yesterday';
    } else if (difference > 1) {
      return 'Due in $difference days';
    } else {
      return 'Overdue by ${difference.abs()} days';
    }
  }

  static bool isDueDateOverdue(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return due.isBefore(today);
  }

  static Future<DateTime?> selectDueDate(BuildContext context, DateTime? currentDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(primary: Theme.of(context).colorScheme.primary)),
          child: child!,
        );
      },
    );
    return picked;
  }

  static String formatDueDate(DateTime dueDate, {bool shortFormat = false}) {
    if (shortFormat) {
      return DateFormat('MMM dd').format(dueDate);
    }
    return DateFormat('EEEE, MMMM dd, yyyy').format(dueDate);
  }

  static String formatCreatedAt(DateTime createdAt) {
    return DateFormat('MMM dd, yyyy').format(createdAt);
  }

  // Filter-related methods
  static IconData getFilterIcon(FilterStatus filter) {
    switch (filter) {
      case FilterStatus.all:
        return FontAwesomeIcons.list;
      case FilterStatus.active:
        return FontAwesomeIcons.clock;
      case FilterStatus.completed:
        return FontAwesomeIcons.circleCheck;
    }
  }

  static String getFilterLabel(FilterStatus filter) {
    switch (filter) {
      case FilterStatus.all:
        return 'All';
      case FilterStatus.active:
        return 'Active';
      case FilterStatus.completed:
        return 'Done';
    }
  }

  static IconData getEmptyStateIcon(FilterStatus filter) {
    switch (filter) {
      case FilterStatus.all:
        return FontAwesomeIcons.clipboardList;
      case FilterStatus.active:
        return FontAwesomeIcons.hourglassHalf;
      case FilterStatus.completed:
        return FontAwesomeIcons.trophy;
    }
  }

  static String getEmptyStateTitle(FilterStatus filter) {
    switch (filter) {
      case FilterStatus.all:
        return 'No tasks yet';
      case FilterStatus.active:
        return 'No active tasks';
      case FilterStatus.completed:
        return 'No completed tasks';
    }
  }

  static String getEmptyStateSubtitle(FilterStatus filter) {
    switch (filter) {
      case FilterStatus.all:
        return 'Create your first task to get started\nwith organizing your day';
      case FilterStatus.active:
        return 'All caught up! No pending tasks\nto work on right now';
      case FilterStatus.completed:
        return 'Complete some tasks to see\nthem appear here';
    }
  }

  // Dialog methods
  static void showDeleteConfirmation({
    required BuildContext context,
    String? taskId,
    String? taskTitle,
    VoidCallback? onDelete,
    bool closeParentScreen = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(FontAwesomeIcons.triangleExclamation, color: Colors.red.shade400, size: 20),
            const SizedBox(width: 12),
            const Text('Delete Task'),
          ],
        ),
        content: Text(
          taskTitle != null
              ? 'Are you sure you want to delete "$taskTitle"? This action is irreversible.'
              : 'Are you sure you want to permanently delete this task? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (onDelete != null) {
                onDelete();
              } else if (taskId != null || taskTitle != null) {
                context.read<TaskBloc>().add(RemoveTask(taskId ?? taskTitle!));
              }
              Navigator.pop(context);
              if (closeParentScreen) {
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400, foregroundColor: Colors.white),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  static void showDiscardChangesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.triangleExclamation, color: Colors.orange.shade400, size: 20),
            const SizedBox(width: 12),
            const Text('Unsaved Changes'),
          ],
        ),
        content: const Text('You have unsaved changes. Are you sure you want to discard them?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Keep Editing')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade400, foregroundColor: Colors.white),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  static void showDeleteAllTasksDialog({required BuildContext context, VoidCallback? onDelete}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(FontAwesomeIcons.triangleExclamation, color: Colors.red.shade400, size: 20),
            const SizedBox(width: 12),
            const Text('Delete All Tasks'),
          ],
        ),
        content: const Text('Are you sure you want to delete all tasks? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (onDelete != null) {
                onDelete();
              } else {
                context.read<TaskBloc>().add(DeleteAllTasks());
              }
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade400, foregroundColor: Colors.white),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
