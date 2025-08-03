import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';

import 'package:todo_ebpearls/core/utils/snackbar_utils.dart';
import 'package:todo_ebpearls/core/utils/todo_utils.dart';
import 'package:todo_ebpearls/presentation/bloc/theme/theme_bloc.dart';
import 'package:todo_ebpearls/presentation/widgets/settings/setting_app_bar.dart';
import 'package:todo_ebpearls/presentation/widgets/settings/setting_theme_selection.dart';
import 'package:todo_ebpearls/presentation/widgets/settings/setting_color_selection.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeAnimationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _slideAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOutQuart));

    _fadeAnimationController.forward();
    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          appBar: SettingAppBar(onBack: () => Navigator.pop(context)),
          body: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    SettingThemeSelection(
                      currentThemeMode: themeState.mode,
                      onThemeSelected: (mode) {
                        context.read<ThemeBloc>().add(UpdateTheme(mode));
                        SnackbarUtils.showSuccess(context, 'Theme updated successfully!');
                      },
                    ),
                    const SizedBox(height: 24),
                    SettingColorSelection(
                      currentSeedColor: themeState.seedColor,
                      onColorSelected: (color) {
                        context.read<ThemeBloc>().add(UpdateSeedColor(color));
                        SnackbarUtils.showSuccess(context, 'App color updated successfully!');
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(13),
                          backgroundColor: context.colorScheme.error,
                          foregroundColor: context.colorScheme.onError,
                        ),
                        onPressed: () => TodoUtils.showDeleteAllTasksDialog(context: context),
                        label: Text(
                          'Delete All Task',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.onError,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: FaIcon(FontAwesomeIcons.trash),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
