import 'package:flutter/material.dart';

class TaskLoadingState extends StatelessWidget {
  const TaskLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 3, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Loading tasks...',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
