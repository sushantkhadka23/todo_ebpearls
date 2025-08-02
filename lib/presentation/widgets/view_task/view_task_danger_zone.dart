import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_utils.dart';

class ViewTaskDangerZone extends StatelessWidget {
  final String taskTitle;
  final VoidCallback onDelete;

  const ViewTaskDangerZone({super.key, required this.taskTitle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.triangleExclamation, size: 18, color: Colors.red.shade400),
            const SizedBox(width: 12),
            Text(
              'Danger Zone',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.red.shade400),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => TaskListUtils.showDeleteConfirmation(taskTitle, context),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.red.shade100, borderRadius: BorderRadius.circular(8)),
                  child: FaIcon(FontAwesomeIcons.trash, color: Colors.red, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delete "$taskTitle"',
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: Colors.red.shade700),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'This action is irreversible',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red.shade700.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
