import 'package:dartz/dartz.dart' as dartz;

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/domain/repositories/task_repository.dart';

class GetTaskById {
  final TaskRepository repository;
  const GetTaskById(this.repository);

  Future<dartz.Either<Exception, Task?>> getTaskById(String id) async {
    return repository.getTaskById(id);
  }
}
