import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_ebpearls/core/extension/theme_extension.dart';
import 'package:todo_ebpearls/presentation/widgets/settings/setting_theme_option_tile.dart';

class SettingThemeSelection extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final Function(ThemeMode) onThemeSelected;

  const SettingThemeSelection({super.key, required this.currentThemeMode, required this.onThemeSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.moon, size: 18, color: context.colorScheme.primary),
            const SizedBox(width: 12),
            Text('Theme Mode', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            ThemeOptionTile(
              title: 'Light Mode',
              subtitle: 'Clean and bright interface',
              icon: FontAwesomeIcons.sun,
              themeMode: ThemeMode.light,
              color: Colors.amber,
              isSelected: currentThemeMode == ThemeMode.light,
              onTap: () => onThemeSelected(ThemeMode.light),
            ),
            const SizedBox(height: 12),
            ThemeOptionTile(
              title: 'Dark Mode',
              subtitle: 'Easy on the eyes in low light',
              icon: FontAwesomeIcons.moon,
              themeMode: ThemeMode.dark,
              color: Colors.indigo,
              isSelected: currentThemeMode == ThemeMode.dark,
              onTap: () => onThemeSelected(ThemeMode.dark),
            ),
            const SizedBox(height: 12),
            ThemeOptionTile(
              title: 'System Default',
              subtitle: 'Follow device system settings',
              icon: FontAwesomeIcons.mobile,
              themeMode: ThemeMode.system,
              color: Colors.green,
              isSelected: currentThemeMode == ThemeMode.system,
              onTap: () => onThemeSelected(ThemeMode.system),
            ),
          ],
        ),
      ],
    );
  }
}
