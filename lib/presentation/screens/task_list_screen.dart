import 'package:flutter/material.dart';
import 'package:todo_ebpearls/core/utils/app_size.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Task List Screen', style: textTheme.titleMedium)),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.viewPadding),
        child: Column(children: []),
      ),
    );
  }
}
