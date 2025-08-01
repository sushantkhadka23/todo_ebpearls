import 'package:dartz/dartz.dart';

import 'package:todo_ebpearls/domain/repositories/task_repository.dart';

class DeleteTask {
  final TaskRepository repository;
  const DeleteTask(this.repository);

  Future<Either<Exception, void>> execute(String id) async {
    return repository.deleteTask(id);
  }
}
