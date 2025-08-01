import 'package:flutter/material.dart';

import 'package:todo_ebpearls/core/router/app_router.dart';
import 'package:todo_ebpearls/core/utils/app_size.dart';
import 'package:todo_ebpearls/core/di/di.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return MaterialApp.router(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
