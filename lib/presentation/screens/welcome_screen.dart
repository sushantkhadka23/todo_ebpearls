import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_ebpearls/core/constants/app_constants.dart';

import 'package:todo_ebpearls/core/router/app_routes.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height * 0.3
        : MediaQuery.of(context).size.height * 0.4;

    final imagWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                height: imageHeight,
                width: imagWidth,
                child: SvgPicture.asset(AppConstants.welcomeImage, fit: BoxFit.contain),
              ),
              const SizedBox(height: 48),
              Text(
                'Welcome to Todo App',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Organize your tasks and boost your productivity',
                style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 72),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => context.pushReplacementNamed(AppRoutesName.taskList),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primary,
                    foregroundColor: context.colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    'Get Started',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
