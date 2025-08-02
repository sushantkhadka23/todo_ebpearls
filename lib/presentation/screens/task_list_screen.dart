import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/core/utils/snackbar_utils.dart';
import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/core/status/app_status.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_filter_selection.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_app_bar.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_empty_state.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_list_view.dart';
import 'package:todo_ebpearls/presentation/widgets/task_list/task_fab.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> with TickerProviderStateMixin {
  FilterStatus _currentFilter = FilterStatus.all;
  bool _sortByDueDate = false;
  late AnimationController _fabAnimationController;
  late AnimationController _filterAnimationController;
  int _previousTaskCount = 0;
  int _previousCompletedCount = 0;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _filterAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  List<Task> _filterTasks(List<Task> tasks) {
    switch (_currentFilter) {
      case FilterStatus.active:
        return tasks.where((task) => !task.isCompleted).toList();
      case FilterStatus.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case FilterStatus.all:
        return tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskListAppBar(
        sortByDueDate: _sortByDueDate,
        onSortToggle: () {
          setState(() {
            _sortByDueDate = !_sortByDueDate;
          });
          context.read<TaskBloc>().add(SortTasksByDueDate(_sortByDueDate));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            TaskFilterSection(
              currentFilter: _currentFilter,
              onFilterChanged: (filter) {
                setState(() {
                  _currentFilter = filter;
                });
                _filterAnimationController.forward().then((_) {
                  _filterAnimationController.reverse();
                });
              },
              animationController: _filterAnimationController,
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
                      SnackbarUtils.showSuccess(context, '$completed of $total tasks completed');
                      _previousTaskCount = total;
                      _previousCompletedCount = completed;
                    }
                  } else if (state.status is Failure) {
                    SnackbarUtils.showError(context, 'Error: ${(state.status as Failure).exception.toString()}');
                  }
                },
                buildWhen: (previous, current) {
                  if (current.status is InProgress) return true;
                  if (current.status is Success) {
                    final tasksEqual =
                        previous.tasks.length == current.tasks.length &&
                        previous.tasks.asMap().entries.every((entry) {
                          final index = entry.key;
                          final task = entry.value;
                          return index < current.tasks.length &&
                              task.id == current.tasks[index].id &&
                              task.isCompleted == current.tasks[index].isCompleted;
                        });
                    return !tasksEqual;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state.status is InProgress) {
                    return CircularProgressIndicator.adaptive();
                  }
                  final filteredTasks = _filterTasks(state.tasks);
                  if (filteredTasks.isEmpty) {
                    return TaskEmptyState(currentFilter: _currentFilter);
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
