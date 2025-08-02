import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskFab extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onPressed;

  const TaskFab({super.key, required this.animationController, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const FaIcon(FontAwesomeIcons.plus, size: 20),
      label: const Text('Add Task'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 4,
    );
  }
}
