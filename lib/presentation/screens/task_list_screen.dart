import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/core/status/app_status.dart';
import 'package:todo_ebpearls/core/utils/snackbar_utils.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_fab.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_view.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_empty_state.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_app_bar.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_failure.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_filter_selection.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late AnimationController _filterAnimationController;

  int _previousTaskCount = 0;
  int _previousCompletedCount = 0;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _filterAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskBloc>().add(LoadTasks());
    });
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _TaskListAppBarWithBloc(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return TaskFilterSection(
                  currentFilter: state.currentFilter,
                  onFilterChanged: (filter) {
                    context.read<TaskBloc>().add(ChangeFilter(filter));
                    _filterAnimationController.forward().then((_) {
                      _filterAnimationController.reverse();
                    });
                  },
                  animationController: _filterAnimationController,
                );
              },
            ),
            Expanded(
              child: BlocConsumer<TaskBloc, TaskState>(
                listenWhen: (previous, current) {
                  if (current.status is Success) {
                    final prevTotal = previous.tasks.length;
                    final currTotal = current.tasks.length;
                    final prevCompleted = previous.tasks.where((task) => task.isCompleted).length;
                    final currCompleted = current.tasks.where((task) => task.isCompleted).length;
                    return prevTotal != currTotal || prevCompleted != currCompleted;
                  }
                  return current.status is Failure;
                },
                listener: (context, state) {
                  if (state.status is Success) {
                    final total = state.tasks.length;
                    final completed = state.tasks.where((task) => task.isCompleted).length;
                    if (total != _previousTaskCount || completed != _previousCompletedCount) {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        if (!context.mounted) return;
                        SnackbarUtils.showSuccess(context, '$completed of $total tasks completed');
                      });
                      _previousTaskCount = total;
                      _previousCompletedCount = completed;
                    }
                  } else if (state.status is Failure) {
                    SnackbarUtils.showError(context, 'Error: ${(state.status as Failure).exception.toString()}');
                  }
                },
                buildWhen: (previous, current) {
                  if (current.status is InProgress && previous.tasks.isNotEmpty) return false;
                  if (current.status is Failure) return true;
                  if (current.status is Success) {
                    return previous.tasks != current.tasks;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state.status is InProgress && state.tasks.isEmpty) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  if (state.status is Failure) {
                    return TaskListFailure();
                  }
                  final filteredTasks = state.tasks;
                  if (filteredTasks.isEmpty) {
                    return TaskEmptyState(currentFilter: state.currentFilter);
                  }
                  return TaskListView(tasks: filteredTasks);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: TaskFab(
        animationController: _fabAnimationController,
        onPressed: () => context.pushNamed(AppRoutesName.addTask),
      ),
    );
  }
}

// Wrapper clss or widget to fix the PreferredSizeWidget for appBar
class _TaskListAppBarWithBloc extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return TaskListAppBar(
          sortByDueDate: state.sortByDueDate,
          onSortToggle: () {
            context.read<TaskBloc>().add(SortTasksByDueDate(!state.sortByDueDate));
          },
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
