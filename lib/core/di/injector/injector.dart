import 'package:get_it/get_it.dart';

import 'package:todo_ebpearls/core/di/feature_modules/bloc_module.dart';
import 'package:todo_ebpearls/core/di/repositories/repositories_module.dart';

final sl = GetIt.instance;

void init() {
  registerRepositoryDependencies(sl);
  registerBlocDependencies(sl);
}
