import 'package:dartz/dartz.dart' as dartz;

import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/domain/repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;
  const UpdateTask(this.repository);

  Future<dartz.Either<Exception, void>> execute(Task task) async {
    return repository.updateTask(task);
  }
}
