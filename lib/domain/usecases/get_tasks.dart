import 'package:dartz/dartz.dart';

import 'package:todo_ebpearls/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;
  const GetTasks(this.repository);

  Future<Either<Exception, void>> execute(String id) async {
    return repository.getTasks();
  }
}
