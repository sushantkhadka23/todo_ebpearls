import 'package:dartz/dartz.dart';

import 'package:todo_ebpearls/domain/repositories/task_repository.dart';

class ToggleTaskCompletion {
  final TaskRepository repository;
  const ToggleTaskCompletion(this.repository);

  Future<Either<Exception, void>> execute(String id, bool isCompleted) async {
    return repository.toggleTaskCompletion(id, isCompleted);
  }
}
