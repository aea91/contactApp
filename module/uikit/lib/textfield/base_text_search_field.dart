import 'package:flutter/material.dart';

class BaseTextSearchField extends StatelessWidget {
  const BaseTextSearchField({
    super.key,
    required this.theme,
    required this.onChanged,
    required this.hintText,
  });

  final ThemeData theme;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodySmall!.copyWith(
          color: theme.hintColor,
        ),
        prefixIcon: Icon(Icons.search, color: theme.hintColor),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
