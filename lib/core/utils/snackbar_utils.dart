import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSuccess(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: const Color(0xFF10B981),
      icon: Icons.check_circle_rounded,
      textColor: Colors.white,
    );
  }

  static void showError(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: const Color(0xFFEF4444),
      icon: Icons.error_rounded,
      textColor: Colors.white,
    );
  }

  static void showWarning(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: const Color(0xFFF59E0B),
      icon: Icons.warning_rounded,
      textColor: Colors.white,
    );
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      message: message,
      backgroundColor: const Color(0xFF3B82F6),
      icon: Icons.info_rounded,
      textColor: Colors.white,
    );
  }

  static void _showSnackbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required Color textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                child: Icon(icon, color: textColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w500, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: const Duration(seconds: 4),
        elevation: 4,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
