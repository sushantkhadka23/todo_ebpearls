import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditTaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasChanges;
  final VoidCallback onBack;
  final VoidCallback onReset;

  const EditTaskAppBar({super.key, required this.hasChanges, required this.onBack, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      leading: IconButton(
        onPressed: onBack,
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const FaIcon(FontAwesomeIcons.arrowLeft, size: 16),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(12)),
            child: FaIcon(FontAwesomeIcons.edit, color: Colors.blue.shade600, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit Task', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                if (hasChanges)
                  Text(
                    'Unsaved changes',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.orange.shade600, fontWeight: FontWeight.w500),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (hasChanges)
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: onReset,
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(8)),
                child: FaIcon(FontAwesomeIcons.rotateLeft, size: 14, color: Colors.orange.shade600),
              ),
              tooltip: 'Reset changes',
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
