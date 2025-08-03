import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/core/utils/todo_utils.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';

class EditTaskPrioritySection extends StatelessWidget {
  final Priority selectedPriority;
  final ValueChanged<Priority> onPriorityChanged;

  const EditTaskPrioritySection({super.key, required this.selectedPriority, required this.onPriorityChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.flag, size: 16, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text('Priority Level', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: Priority.values.map((priority) {
            final isSelected = selectedPriority == priority;
            return Expanded(
              child: GestureDetector(
                onTap: () => onPriorityChanged(priority),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? TodoUtils.getPriorityColor(priority).withOpacity(0.15)
                        : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? TodoUtils.getPriorityColor(priority)
                          : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: TodoUtils.getPriorityColor(priority).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FaIcon(
                          TodoUtils.getPriorityIcon(priority),
                          color: TodoUtils.getPriorityColor(priority),
                          size: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        priority.name.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? TodoUtils.getPriorityColor(priority) : Theme.of(context).colorScheme.onSurface,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
