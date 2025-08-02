import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/presentation/bloc/task_bloc.dart';

class TaskListUtils {
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

  static IconData getFilterIcon(FilterStatus filter) {
    switch (filter) {
      case FilterStatus.all:
        return FontAwesomeIcons.list;
      case FilterStatus.active:
        return FontAwesomeIcons.clock;
      case FilterStatus.completed:
        return FontAwesomeIcons.checkCircle;
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

  static bool isDueDateOverdue(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return due.isBefore(today);
  }

  static String formatDueDate(DateTime dueDate) {
    return DateFormat('MMM dd').format(dueDate);
  }

  static String formatCreatedAt(DateTime createdAt) {
    return DateFormat('MMM dd, yyyy').format(createdAt);
  }

  static showDeleteConfirmation(String id, BuildContext context) {
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
        content: Text('Are you sure you want to delete this task? This action is irreversible.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              context.read<TaskBloc>().add(RemoveTask(id));
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
