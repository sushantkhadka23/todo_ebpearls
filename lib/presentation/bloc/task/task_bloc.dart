import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/core/status/app_status.dart';
import 'package:todo_ebpearls/domain/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  List<Task> _allTasks = [];

  TaskBloc({required this.taskRepository}) : super(const TaskState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddNewTask>(_onAddNewTask);
    on<ChangeTask>(_onUpdateTask);
    on<GetSingleTask>(_onGetTaskById);
    on<RemoveTask>(_onDeleteTask);
    on<UpdateTaskCompletion>(_onToggleTaskCompletion);
    on<SortTasksByDueDate>(_onSortTasksByDueDate);
    on<ChangeFilter>(_onChangeFilter);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }

  List<Task> _filterAndSortTasks(List<Task> tasks, FilterStatus filter, bool sortByDueDate) {
    List<Task> filteredTasks;
    switch (filter) {
      case FilterStatus.active:
        filteredTasks = tasks.where((task) => !task.isCompleted).toList();
        break;
      case FilterStatus.completed:
        filteredTasks = tasks.where((task) => task.isCompleted).toList();
        break;
      case FilterStatus.all:
        filteredTasks = List.from(tasks);
        break;
    }
    if (sortByDueDate) {
      filteredTasks.sort((a, b) {
        if (a.dueDate == null && b.dueDate == null) return 0;
        if (a.dueDate == null) return 1;
        if (b.dueDate == null) return -1;
        return a.dueDate!.compareTo(b.dueDate!);
      });
    }
    return filteredTasks;
  }

  _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await taskRepository.getTasks(sortByDueDate: false);
    result.fold((failure) => emit(state.copyWith(status: Failure(failure), tasks: [])), (tasks) {
      _allTasks = tasks;
      final filteredSorted = _filterAndSortTasks(_allTasks, state.currentFilter, state.sortByDueDate);
      emit(state.copyWith(tasks: filteredSorted, status: const Success()));
    });
  }

  _onAddNewTask(AddNewTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await taskRepository.addTask(event.task);
    await result.fold((failure) async => emit(state.copyWith(status: Failure(failure))), (_) async {
      final tasksResult = await taskRepository.getTasks();
      tasksResult.fold((failure) => emit(state.copyWith(status: Failure(failure))), (tasks) {
        _allTasks = tasks;
        final filteredSorted = _filterAndSortTasks(_allTasks, state.currentFilter, state.sortByDueDate);
        emit(state.copyWith(tasks: filteredSorted, status: const Success()));
      });
    });
  }

  _onUpdateTask(ChangeTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await taskRepository.updateTask(event.task);
    await result.fold((failure) async => emit(state.copyWith(status: Failure(failure))), (_) async {
      final tasksResult = await taskRepository.getTasks();
      tasksResult.fold((failure) => emit(state.copyWith(status: Failure(failure))), (tasks) {
        _allTasks = tasks;
        final filteredSorted = _filterAndSortTasks(_allTasks, state.currentFilter, state.sortByDueDate);
        emit(state.copyWith(tasks: filteredSorted, task: null, status: const Success()));
      });
    });
  }

  _onGetTaskById(GetSingleTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await taskRepository.getTaskById(event.id);
    result.fold(
      (failure) => emit(state.copyWith(status: Failure(failure), task: null)),
      (task) => emit(state.copyWith(task: task, status: const Success())),
    );
  }

  _onDeleteTask(RemoveTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await taskRepository.deleteTask(event.id);
    await result.fold((failure) async => emit(state.copyWith(status: Failure(failure))), (_) async {
      final tasksResult = await taskRepository.getTasks();
      tasksResult.fold((failure) => emit(state.copyWith(status: Failure(failure))), (tasks) {
        _allTasks = tasks;
        final filteredSorted = _filterAndSortTasks(_allTasks, state.currentFilter, state.sortByDueDate);
        emit(state.copyWith(tasks: filteredSorted, status: const Success()));
      });
    });
  }

  _onToggleTaskCompletion(UpdateTaskCompletion event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await taskRepository.toggleTaskCompletion(event.id, event.isCompleted);
    await result.fold((failure) async => emit(state.copyWith(status: Failure(failure))), (_) async {
      final tasksResult = await taskRepository.getTasks();
      tasksResult.fold((failure) => emit(state.copyWith(status: Failure(failure))), (tasks) {
        _allTasks = tasks;
        final filteredSorted = _filterAndSortTasks(_allTasks, state.currentFilter, state.sortByDueDate);
        emit(state.copyWith(tasks: filteredSorted, status: const Success()));
      });
    });
  }

  _onSortTasksByDueDate(SortTasksByDueDate event, Emitter<TaskState> emit) async {
    final bool newSortByDueDate = event.sortByDueDate;
    final filteredSorted = _filterAndSortTasks(_allTasks, state.currentFilter, newSortByDueDate);
    emit(state.copyWith(tasks: filteredSorted, sortByDueDate: newSortByDueDate, status: const Success()));
  }

  _onChangeFilter(ChangeFilter event, Emitter<TaskState> emit) async {
    final FilterStatus newFilter = event.filter;
    final filteredSorted = _filterAndSortTasks(_allTasks, newFilter, state.sortByDueDate);
    emit(state.copyWith(tasks: filteredSorted, currentFilter: newFilter, status: const Success()));
  }

  _onDeleteAllTasks(DeleteAllTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await taskRepository.deleteAllTasks();
    await result.fold((failure) async => emit(state.copyWith(status: Failure(failure))), (_) async {
      _allTasks = [];
      final filteredSorted = _filterAndSortTasks(_allTasks, state.currentFilter, state.sortByDueDate);
      emit(state.copyWith(tasks: filteredSorted, task: null, status: const Success()));
    });
  }
}
