import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';

class TaskListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool sortByDueDate;
  final VoidCallback onSortToggle;

  const TaskListAppBar({super.key, required this.sortByDueDate, required this.onSortToggle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(FontAwesomeIcons.clipboardCheck, color: Theme.of(context).colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Tasks', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  final tasks = state.tasks;
                  final completedCount = tasks.where((task) => task.isCompleted).length;
                  return Text(
                    '${tasks.length} tasks, $completedCount completed',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onSortToggle,
          icon: AnimatedRotation(
            turns: sortByDueDate ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: FaIcon(sortByDueDate ? FontAwesomeIcons.arrowDownWideShort : FontAwesomeIcons.sort, size: 20),
          ),
          tooltip: sortByDueDate ? 'Sort by date' : 'Default order',
        ),
        const SizedBox(width: 8),
        IconButton(onPressed: () => context.pushNamed(AppRoutesName.settings), icon: const FaIcon(FontAwesomeIcons.gear)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
