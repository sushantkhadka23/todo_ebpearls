import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';

class AddTaskUtils {
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

  static Future<DateTime?> selectDueDate(BuildContext context, DateTime? currentDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
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

  static String formatDueDate(DateTime dueDate) {
    return DateFormat('EEEE, MMMM dd, yyyy').format(dueDate);
  }
}
