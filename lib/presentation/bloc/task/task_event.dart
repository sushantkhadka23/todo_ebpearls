part of 'task_bloc.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {
  final bool sortByDueDate;
  LoadTasks({this.sortByDueDate = false});
}

class AddNewTask extends TaskEvent {
  final Task task;
  AddNewTask(this.task);
}

class ChangeTask extends TaskEvent {
  final Task task;
  ChangeTask(this.task);
}

class GetSingleTask extends TaskEvent {
  final String id;

  GetSingleTask(this.id);
}

class RemoveTask extends TaskEvent {
  final String id;
  RemoveTask(this.id);
}

class UpdateTaskCompletion extends TaskEvent {
  final String id;
  final bool isCompleted;
  UpdateTaskCompletion(this.id, this.isCompleted);
}

class SortTasksByDueDate extends TaskEvent {
  final bool sortByDueDate;
  SortTasksByDueDate(this.sortByDueDate);
}
