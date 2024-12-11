import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    super.key,
    required this.child,
    this.isScrollControlled = true,
    this.duration,
  });

  final Widget child;
  final bool isScrollControlled;
  final Duration? duration;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = true,
    Duration? duration,
  }) {
    if (duration != null) {
      Future.delayed(duration, () {
        // Check if context is still mounted before popping
        GoManager.instance.pop();
      });
    }

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (_) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (duration != null) {
      Future.delayed(duration!, () {
        // Check if context is still mounted before popping
        GoManager.instance.pop();
      });
    }
    return child;
  }
}
