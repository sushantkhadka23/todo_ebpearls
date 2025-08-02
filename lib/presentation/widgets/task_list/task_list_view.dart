import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_card.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_utils.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;

  const TaskListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          index: index,
          onToggleCompletion: () => context.read<TaskBloc>().add(UpdateTaskCompletion(task.id, !task.isCompleted)),
          onView: () => context.pushNamed(AppRoutesName.viewTask, pathParameters: {'taskId': task.id}),
          onEdit: () => context.pushNamed(AppRoutesName.editTask, pathParameters: {'taskId': task.id}),
          onDelete: () => TaskListUtils.showDeleteConfirmation(task.id, context),
        );
      },
    );
  }
}
