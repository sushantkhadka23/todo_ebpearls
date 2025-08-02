import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:todo_ebpearls/core/utils/app_size.dart';
import 'package:todo_ebpearls/core/router/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSize.viewMargin),
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                height: AppSize.isPortrait ? AppSize.screenHeight * 0.3 : AppSize.screenHeight * 0.4,
                width: AppSize.screenWidth * 0.8,
                child: SvgPicture.asset('assets/images/welcome.svg', fit: BoxFit.contain),
              ),
              const SizedBox(height: AppSize.spacedViewSpacing),
              Text(
                'Welcome to Todo App',
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600, color: colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSize.viewMargin),
              Text(
                'Organize your tasks and boost your productivity',
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSize.spacedViewSpacing * 1.5),
              SizedBox(
                width: double.infinity,
                height: AppSize.buttonHeight,
                child: ElevatedButton(
                  onPressed: () => context.pushReplacementNamed(AppRoutesName.taskList),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.cornerRadius)),
                  ),
                  child: Text(
                    'Get Started',
                    style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              // Bottom spacer
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
