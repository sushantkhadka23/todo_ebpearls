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

class _TaskListScreenState extends State<TaskListScreen> with TickerProviderStateMixin, RouteAware {
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

    // Load tasks when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskBloc>().add(LoadTasks(sortByDueDate: _sortByDueDate));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TaskBloc>().add(LoadTasks(sortByDueDate: _sortByDueDate));
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  List<Task> _filterTasks(List<Task> tasks) {
    List<Task> filteredTasks;
    switch (_currentFilter) {
      case FilterStatus.active:
        filteredTasks = tasks.where((task) => !task.isCompleted).toList();
        break;
      case FilterStatus.completed:
        filteredTasks = tasks.where((task) => task.isCompleted).toList();
        break;
      case FilterStatus.all:
        filteredTasks = tasks;
        break;
    }
    if (_sortByDueDate) {
      filteredTasks.sort((a, b) {
        if (a.dueDate == null && b.dueDate == null) return 0;
        if (a.dueDate == null) return 1;
        if (b.dueDate == null) return -1;
        return a.dueDate!.compareTo(b.dueDate!);
      });
    }
    return filteredTasks;
  }

  // Helper method to check if two tasks are equal
  bool _areTasksEqual(Task task1, Task task2) {
    return task1.id == task2.id &&
        task1.title == task2.title &&
        task1.description == task2.description &&
        task1.isCompleted == task2.isCompleted &&
        task1.priority == task2.priority &&
        task1.dueDate == task2.dueDate &&
        task1.createdAt == task2.createdAt;
  }

  // Helper method to check if two task lists are equal
  bool _areTaskListsEqual(List<Task> list1, List<Task> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (!_areTasksEqual(list1[i], list2[i])) return false;
    }
    return true;
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
        padding: const EdgeInsets.symmetric(horizontal: 2),
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
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        if (!context.mounted) return;
                        if (mounted) {
                          SnackbarUtils.showSuccess(context, '$completed of $total tasks completed');
                        }
                      });
                      _previousTaskCount = total;
                      _previousCompletedCount = completed;
                    }
                  } else if (state.status is Failure) {
                    SnackbarUtils.showError(context, 'Error: ${(state.status as Failure).exception.toString()}');
                  }
                },
                buildWhen: (previous, current) {
                  // Skip InProgress unless tasks are empty or significantly changed
                  if (current.status is InProgress && previous.tasks.isNotEmpty) return false;
                  if (current.status is Failure) return true;
                  if (current.status is Success) {
                    return !_areTaskListsEqual(previous.tasks, current.tasks);
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state.status is InProgress && state.tasks.isEmpty) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  if (state.status is Failure) {
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
