import 'package:dartz/dartz.dart' as dartz;

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/core/exception/app_exception.dart';
import 'package:todo_ebpearls/domain/repositories/task_repository.dart';
import 'package:todo_ebpearls/data/data_sources/local_data_source.dart';

class TaskRepositoryImpl extends TaskRepository {
  final LocalDataSource localDataSource;
  TaskRepositoryImpl(this.localDataSource);
  @override
  Future<dartz.Either<Exception, void>> addTask(Task task) async {
    try {
      await localDataSource.addTask(task);
      return dartz.Right(null);
    } on DatabaseException catch (e) {
      return dartz.left(e);
    } catch (e) {
      return dartz.left(DatabaseException('Failed to add task: $e'));
    }
  }

  @override
  Future<dartz.Either<Exception, void>> deleteTask(String id) async {
    try {
      await localDataSource.deleteTask(id);
      return dartz.Right(null);
    } on DatabaseException catch (e) {
      return dartz.left(e);
    } catch (e) {
      return dartz.left(DatabaseException('Failed to delete task: $e'));
    }
  }

  @override
  Future<dartz.Either<Exception, List<Task>>> getTasks({bool sortByDueDate = false}) async {
    try {
      final tasks = await localDataSource.getTasks(sortByDueDate: sortByDueDate);
      return dartz.Right(tasks);
    } on TaskNotFoundException catch (e) {
      return dartz.left(e);
    } on DatabaseException catch (e) {
      return dartz.left(e);
    } catch (e) {
      return dartz.left(DatabaseException('Failed to get tasks: $e'));
    }
  }

  @override
  Future<dartz.Either<Exception, Task?>> getTaskById(String id) async {
    try {
      final task = await localDataSource.getTaskById(id);
      if (task == null) {
        return dartz.left(TaskNotFoundException('Task with id $id not found'));
      }
      return dartz.Right(task);
    } on TaskNotFoundException catch (e) {
      return dartz.left(e);
    } on DatabaseException catch (e) {
      return dartz.left(e);
    } catch (e) {
      return dartz.left(DatabaseException('Failed to get task by id: $e'));
    }
  }

  @override
  Future<dartz.Either<Exception, void>> toggleTaskCompletion(String id, bool isCompleted) async {
    try {
      await localDataSource.toggleTaskCompletion(id, isCompleted);
      return dartz.Right(null);
    } on DatabaseException catch (e) {
      return dartz.left(e);
    } catch (e) {
      return dartz.left(DatabaseException('Failed to toggle task completion: $e'));
    }
  }

  @override
  Future<dartz.Either<Exception, void>> updateTask(Task task) async {
    try {
      await localDataSource.updateTask(task);
      return dartz.Right(null);
    } on TaskNotFoundException catch (e) {
      return dartz.left(e);
    } on DatabaseException catch (e) {
      return dartz.left(e);
    } catch (e) {
      return dartz.left(DatabaseException('Failed to update task: $e'));
    }
  }

  @override
  Future<dartz.Either<Exception, void>> deleteAllTasks() async {
    try {
      await localDataSource.deleteDatabase();
      return dartz.Right(null);
    } on DatabaseException catch (e) {
      return dartz.left(e);
    } catch (e) {
      return dartz.left(DatabaseException('Failed to delete database: $e'));
    }
  }
}
