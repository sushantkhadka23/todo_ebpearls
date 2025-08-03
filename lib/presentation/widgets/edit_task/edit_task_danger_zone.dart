import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditTaskDangerZone extends StatelessWidget {
  final String taskTitle;
  final VoidCallback onDelete;

  const EditTaskDangerZone({super.key, required this.taskTitle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(FontAwesomeIcons.triangleExclamation, color: Colors.red.shade600, size: 16),
              const SizedBox(width: 8),
              Text(
                'Danger Zone',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.red.shade700),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Once you delete this task, there is no going back. Please be certain.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red.shade600),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onDelete,
              icon: const FaIcon(FontAwesomeIcons.trash, size: 16),
              label: const Text('Delete Task'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red.shade600,
                side: BorderSide(color: Colors.red.shade400),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
