part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> tasks;
  final Task? task;
  final AppStatus status;
  final FilterStatus currentFilter;
  final bool sortByDueDate;

  const TaskState({
    this.tasks = const [],
    this.task,
    this.status = const Initial(),
    this.currentFilter = FilterStatus.all,
    this.sortByDueDate = false,
  });

  @override
  List<Object?> get props => [tasks, task, status, currentFilter, sortByDueDate];

  TaskState copyWith({List<Task>? tasks, Task? task, AppStatus? status, FilterStatus? currentFilter, bool? sortByDueDate}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      task: task ?? this.task,
      status: status ?? this.status,
      currentFilter: currentFilter ?? this.currentFilter,
      sortByDueDate: sortByDueDate ?? this.sortByDueDate,
    );
  }
}
