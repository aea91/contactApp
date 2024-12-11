import 'package:flutter/material.dart';

class BaseActionButton extends StatelessWidget {
  const BaseActionButton({
    super.key,
    required this.icon,
    required this.theme,
    required this.onTap,
  });

  final IconData icon;
  final ThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.onPrimary, // Mavi arka plan
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: onTap,
          icon: Icon(
            icon,
            color: Colors.white,
            size: 24, // İkon boyutunu küçülttüm
          ),
        ),
      ),
    );
  }
}
