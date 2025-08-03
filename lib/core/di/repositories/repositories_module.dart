import 'package:get_it/get_it.dart';

import 'package:todo_ebpearls/core/services/local_storage_service.dart';
import 'package:todo_ebpearls/data/data_sources/local_data_source.dart';
import 'package:todo_ebpearls/data/repositories/theme_repository_impl.dart';
import 'package:todo_ebpearls/domain/repositories/task_repository.dart';
import 'package:todo_ebpearls/data/repositories/task_repository_impl.dart';
import 'package:todo_ebpearls/domain/repositories/theme_repository.dart';

void registerRepositoryDependencies(GetIt sl) {
  // register local storage service
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  // register local data source
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSource(sl<LocalStorageService>()));
  // register task repo
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl<LocalDataSource>()));
  // register theme repo
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl());
}
