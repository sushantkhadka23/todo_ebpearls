import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/core/utils/todo_utils.dart';

import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';

class TaskEmptyState extends StatelessWidget {
  final FilterStatus currentFilter;

  const TaskEmptyState({super.key, required this.currentFilter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: context.colorScheme.surface),
            child: FaIcon(
              TodoUtils.getEmptyStateIcon(currentFilter),
              size: 48,
              color: context.colorScheme.primary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            TodoUtils.getEmptyStateTitle(currentFilter),
            style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            TodoUtils.getEmptyStateSubtitle(currentFilter),
            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurface.withOpacity(0.6)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => context.pushNamed(AppRoutesName.addTask),
            icon: const FaIcon(FontAwesomeIcons.plus, size: 16),
            label: const Text('Add Your First Task'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
