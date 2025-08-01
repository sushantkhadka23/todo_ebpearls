import 'package:go_router/go_router.dart';

import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/presentation/screens/task_form_screen.dart';
import 'package:todo_ebpearls/presentation/screens/task_list_screen.dart';
import 'package:todo_ebpearls/presentation/screens/welcome_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.welcome,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        name: AppRoutesName.welcome,
        builder: (context, state) {
          return WelcomeScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.taskList,
        name: AppRoutesName.taskList,
        builder: (context, state) {
          return TaskListScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.taskForm,
        name: AppRoutesName.taskForm,
        builder: (context, state) {
          return TaskFormScreen();
        },
      ),
    ],
  );
}
