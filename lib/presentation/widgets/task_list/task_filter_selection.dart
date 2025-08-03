import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_ebpearls/core/utils/todo_utils.dart';

import 'package:todo_ebpearls/domain/entity/enums.dart';
import 'package:todo_ebpearls/core/extension/theme_extension.dart';

class TaskFilterSection extends StatelessWidget {
  final FilterStatus currentFilter;
  final ValueChanged<FilterStatus> onFilterChanged;
  final AnimationController animationController;

  const TaskFilterSection({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: FilterStatus.values.map((filter) {
          final isSelected = currentFilter == filter;
          return Expanded(
            child: GestureDetector(
              onTap: () => onFilterChanged(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: isSelected ? context.colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: context.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      TodoUtils.getFilterIcon(filter),
                      size: 16,
                      color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      TodoUtils.getFilterLabel(filter),
                      style: TextStyle(
                        color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
