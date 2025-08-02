import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_ebpearls/core/utils/snackbar_utils.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_ebpearls/core/status/app_status.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/presentation/bloc/task/task_bloc.dart';
import 'package:todo_ebpearls/presentation/widgets/add_task/add_task_app_bar.dart';
import 'package:todo_ebpearls/presentation/widgets/add_task/add_task_header.dart';
import 'package:todo_ebpearls/presentation/widgets/add_task/add_task_title_field.dart';
import 'package:todo_ebpearls/presentation/widgets/add_task/add_task_description_field.dart';
import 'package:todo_ebpearls/presentation/widgets/add_task/add_task_priority_section.dart';
import 'package:todo_ebpearls/presentation/widgets/add_task/add_task_due_date_section.dart';
import 'package:todo_ebpearls/presentation/widgets/add_task/add_task_bottom_section.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Priority _selectedPriority = Priority.medium;
  DateTime? _selectedDueDate;
  bool _isFormValid = false;

  late AnimationController _slideAnimationController;
  late AnimationController _fadeAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _slideAnimationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _fadeAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOutQuart));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeOut));

    _titleController.addListener(_validateForm);

    _fadeAnimationController.forward();
    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _slideAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _titleController.text.trim().isNotEmpty;
    });
  }

  void _saveTask() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      const uuid = Uuid();
      final task = Task(
        id: uuid.v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
        createdAt: DateTime.now(),
        dueDate: _selectedDueDate,
        priority: _selectedPriority,
      );

      context.read<TaskBloc>().add(AddNewTask(task));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const AddTaskAppBar(),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state.status is Success) {
            SnackbarUtils.showSuccess(context, 'Task added successfully!');
            Navigator.pop(context);
          } else if (state.status is Failure) {
            SnackbarUtils.showError(context, 'Error: ${(state.status as Failure).exception.toString()}');
          }
        },
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AddTaskHeader(),
                          const SizedBox(height: 24),
                          AddTaskTitleField(controller: _titleController),
                          const SizedBox(height: 20),
                          AddTaskDescriptionField(controller: _descriptionController),
                          const SizedBox(height: 24),
                          AddTaskPrioritySection(
                            selectedPriority: _selectedPriority,
                            onPriorityChanged: (priority) {
                              setState(() {
                                _selectedPriority = priority;
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          AddTaskDueDateSection(
                            selectedDueDate: _selectedDueDate,
                            onDueDateSelected: (date) {
                              setState(() {
                                _selectedDueDate = date;
                              });
                            },
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
                AddTaskBottomSection(isFormValid: _isFormValid, onCancel: () => Navigator.pop(context), onSave: _saveTask),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
