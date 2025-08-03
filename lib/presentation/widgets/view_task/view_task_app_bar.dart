import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_ebpearls/core/extension/theme_extension.dart';

class ViewTaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String taskTitle;
  final VoidCallback onBack;

  const ViewTaskAppBar({super.key, required this.taskTitle, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: context.colorScheme.onSurface,
      leading: IconButton(
        onPressed: onBack,
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FaIcon(FontAwesomeIcons.arrowLeft, size: 16, color: context.colorScheme.onSurface),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: context.colorScheme.primary, borderRadius: BorderRadius.circular(12)),
            child: FaIcon(FontAwesomeIcons.listCheck, color: context.colorScheme.surface, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              taskTitle,
              style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
