import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_ebpearls/core/status/app_status.dart';
import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/domain/usecases/add_task.dart';
import 'package:todo_ebpearls/domain/usecases/get_tasks.dart';
import 'package:todo_ebpearls/domain/usecases/update_task.dart';
import 'package:todo_ebpearls/domain/usecases/delete_task.dart';
import 'package:todo_ebpearls/domain/usecases/get_task_by_id.dart';
import 'package:todo_ebpearls/domain/usecases/toggle_task_completion.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTask addTask;
  final DeleteTask deleteTask;
  final GetTaskById getTaskById;
  final GetTasks getTasks;
  final ToggleTaskCompletion toggleTaskCompletion;
  final UpdateTask updateTask;

  TaskBloc({
    required this.addTask,
    required this.deleteTask,
    required this.getTaskById,
    required this.getTasks,
    required this.toggleTaskCompletion,
    required this.updateTask,
  }) : super(const TaskState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddNewTask>(_onAddNewTask);
    on<ChangeTask>(_onUpdateTask);
    on<GetSingleTask>(_onGetTaskById);
    on<RemoveTask>(_onDeleteTask);
    on<UpdateTaskCompletion>(_onToggleTaskCompletion);
    on<SortTasksByDueDate>(_onSortTasksByDueDate);
  }

  _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await getTasks.execute(sortByDueDate: event.sortByDueDate);
    result.fold(
      (failure) => emit(state.copyWith(status: Failure(failure), tasks: [])),
      (tasks) => emit(state.copyWith(tasks: tasks, task: null, status: const Success())),
    );
  }

  _onAddNewTask(AddNewTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await addTask.execute(event.task);
    await result.fold((failure) async => emit(state.copyWith(status: Failure(failure))), (_) async {
      final tasksResult = await getTasks.execute();
      tasksResult.fold(
        (failure) => emit(state.copyWith(status: Failure(failure))),
        (tasks) => emit(state.copyWith(tasks: tasks, status: const Success())),
      );
    });
  }

  _onUpdateTask(ChangeTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await updateTask.execute(event.task);
    await result.fold((failure) async => emit(state.copyWith(status: Failure(failure))), (_) async {
      final tasksResult = await getTasks.execute();
      tasksResult.fold(
        (failure) => emit(state.copyWith(status: Failure(failure))),
        (tasks) => emit(state.copyWith(tasks: tasks, task: event.task, status: const Success())),
      );
    });
  }

  _onGetTaskById(GetSingleTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await getTaskById.execute(event.id);
    result.fold(
      (failure) => emit(state.copyWith(status: Failure(failure), task: null)),
      (task) => emit(state.copyWith(task: task, status: const Success())),
    );
  }

  _onDeleteTask(RemoveTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await deleteTask.execute(event.id);
    await result.fold((failure) async => emit(state.copyWith(status: Failure(failure))), (_) async {
      final tasksResult = await getTasks.execute();
      tasksResult.fold(
        (failure) => emit(state.copyWith(status: Failure(failure))),
        (tasks) => emit(state.copyWith(tasks: tasks, status: const Success())),
      );
    });
  }

  _onToggleTaskCompletion(UpdateTaskCompletion event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await toggleTaskCompletion.execute(event.id, event.isCompleted);
    await result.fold((failure) async => emit(state.copyWith(status: Failure(failure))), (_) async {
      final tasksResult = await getTasks.execute();
      tasksResult.fold(
        (failure) => emit(state.copyWith(status: Failure(failure))),
        (tasks) => emit(state.copyWith(tasks: tasks, status: const Success())),
      );
    });
  }

  _onSortTasksByDueDate(SortTasksByDueDate event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: const InProgress()));
    final result = await getTasks.execute(sortByDueDate: event.sortByDueDate);
    result.fold(
      (failure) => emit(state.copyWith(status: Failure(failure))),
      (tasks) => emit(state.copyWith(tasks: tasks, status: const Success())),
    );
  }
}
