import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/core/utils/app_size.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Welcome Screen', style: textTheme.titleMedium)),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.viewPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => context.pushReplacementNamed(AppRoutesName.taskList),
                label: Text('Task List'),
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
