import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_ebpearls/core/extension/theme_extension.dart';

class SettingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;

  const SettingAppBar({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: onBack,
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const FaIcon(FontAwesomeIcons.arrowLeft, size: 16),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: context.colorScheme.primary, borderRadius: BorderRadius.circular(12)),
            child: FaIcon(FontAwesomeIcons.gear, color: context.colorScheme.surface, size: 20),
          ),
          const SizedBox(width: 12),
          Text('Settings', style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
