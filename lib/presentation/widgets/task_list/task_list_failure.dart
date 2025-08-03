import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';

class TaskListFailure extends StatelessWidget {
  const TaskListFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 16),
          Text('Something went wrong', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Please try again', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<TaskBloc>().add(LoadTasks());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
