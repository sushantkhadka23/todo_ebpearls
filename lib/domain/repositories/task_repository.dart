import 'package:dartz/dartz.dart' as dartz;

import 'package:todo_ebpearls/domain/entity/task.dart';

abstract class TaskRepository {
  Future<dartz.Either<Exception, List<Task>>> getTasks({bool sortByDueDate = false});
  Future<dartz.Either<Exception, Task?>> getTaskById(String id);
  Future<dartz.Either<Exception, void>> addTask(Task task);
  Future<dartz.Either<Exception, void>> updateTask(Task task);
  Future<dartz.Either<Exception, void>> deleteTask(String id);
  Future<dartz.Either<Exception, void>> toggleTaskCompletion(String id, bool isCompleted);
  Future<dartz.Either<Exception, void>> deleteAllTasks();
}
