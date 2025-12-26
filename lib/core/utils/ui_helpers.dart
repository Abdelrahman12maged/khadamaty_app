import 'package:flutter/material.dart';

/// Reusable UI utilities for showing dialogs, snackbars, etc.
class UIHelpers {
  UIHelpers._();

  /// Show a confirmation dialog
  ///
  /// Returns true if confirmed, false if cancelled
  static Future<bool> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    String? cancelText,
    Color? confirmColor,
    bool isDangerous = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(cancelText ?? 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDangerous ? Colors.red : confirmColor,
              foregroundColor: Colors.white,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Show a success snackbar
  static void showSuccessSnackbar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: duration,
      ),
    );
  }

  /// Show an error snackbar
  static void showErrorSnackbar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: duration,
      ),
    );
  }

  /// Show an info snackbar
  static void showInfoSnackbar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }

  /// Handle delete action with confirmation dialog and success message
  ///
  /// Returns true if deleted successfully, false if cancelled
  static Future<bool> deleteWithConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    required String itemName,
    required String confirmText,
    required String cancelText,
    required Future<void> Function() onDelete,
    String? successMessage,
  }) async {
    final confirmed = await showConfirmDialog(
      context: context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      isDangerous: true,
    );

    if (confirmed && context.mounted) {
      try {
        await onDelete();

        if (context.mounted) {
          showSuccessSnackbar(
            context: context,
            message: successMessage ?? 'Deleted: $itemName',
          );
        }
        return true;
      } catch (e) {
        if (context.mounted) {
          showErrorSnackbar(
            context: context,
            message: 'Failed to delete: ${e.toString()}',
          );
        }
        return false;
      }
    }

    return false;
  }
}
