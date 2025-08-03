import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/core/utils/todo_utils.dart';

class AddTaskDueDateSection extends StatelessWidget {
  final DateTime? selectedDueDate;
  final ValueChanged<DateTime?> onDueDateSelected;

  const AddTaskDueDateSection({super.key, required this.selectedDueDate, required this.onDueDateSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.calendar, size: 16, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text('Due Date', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            Text(
              '(optional)',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            final picked = await TodoUtils.selectDueDate(context, selectedDueDate);
            if (picked != null && picked != selectedDueDate) {
              onDueDateSelected(picked);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: selectedDueDate != null
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.05)
                  : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedDueDate != null
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                    : Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selectedDueDate != null
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                        : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.calendarDays,
                    size: 16,
                    color: selectedDueDate != null
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedDueDate != null ? TodoUtils.formatDueDate(selectedDueDate!) : 'Select due date',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: selectedDueDate != null ? FontWeight.w600 : FontWeight.normal,
                          color: selectedDueDate != null
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      if (selectedDueDate != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          TodoUtils.getDueDateRelativeText(selectedDueDate!),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ],
                  ),
                ),
                if (selectedDueDate != null) ...[
                  GestureDetector(
                    onTap: () => onDueDateSelected(null),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade400.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: FaIcon(FontAwesomeIcons.xmark, size: 12, color: Colors.red.shade400),
                    ),
                  ),
                ] else ...[
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
