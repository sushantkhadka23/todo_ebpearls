import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';

class ViewTaskHeader extends StatelessWidget {
  const ViewTaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [context.colorScheme.primary, context.colorScheme.primary.withOpacity(0.8)],
        ),
        boxShadow: [
          BoxShadow(color: context.colorScheme.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8)),
          BoxShadow(color: context.colorScheme.primary.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.colorScheme.onPrimary.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            // Icon container with enhanced styling
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: FaIcon(FontAwesomeIcons.listCheck, color: context.colorScheme.primary, size: 24),
            ),
            const SizedBox(width: 20),

            // Text content with improved hierarchy
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Overview',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Comprehensive details and information',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onPrimary.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // Decorative element
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
