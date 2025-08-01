import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/core/services/local_storage_service.dart';

class LocalDataSource {
  final LocalStorageService service;
  const LocalDataSource(this.service);

  Future<void> addTask(Task task) async {
    await service.addTask(task);
  }

  Future<void> updateTask(Task task) async {
    await service.updateTask(task);
  }

  Future<void> deleteTask(String id) async {
    await service.deleteTask(id);
  }

  Future<List<Task>> getTasks({bool sortByDueDate = false}) async {
    return await service.getTasks(sortByDueDate: sortByDueDate);
  }

  Future<Task?> getTaskById(String id) async {
    return await service.getTaskById(id);
  }

  Future<void> toggleTaskCompletion(String id, bool isCompleted) async {
    await service.toggleTaskCompletion(id, isCompleted);
  }
}
