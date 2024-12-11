import 'package:flutter/material.dart';

class BaseBottomSheetContainer extends StatelessWidget {
  const BaseBottomSheetContainer({
    super.key,
    required this.child,
    this.decoration,
    this.padding,
    required this.theme,
  });

  final Widget child;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ??
          BoxDecoration(
            color: theme?.colorScheme.onSurface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
