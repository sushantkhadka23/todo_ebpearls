import 'package:dartz/dartz.dart' as dartz;

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;
  const GetTasks(this.repository);

  Future<dartz.Either<Exception, List<Task>>> execute({bool sortByDueDate = false}) {
    return repository.getTasks(sortByDueDate: sortByDueDate);
  }
}
