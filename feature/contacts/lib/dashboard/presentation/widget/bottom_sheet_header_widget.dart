import 'package:core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class BottomSheetHeaderWidget extends StatelessWidget {
  const BottomSheetHeaderWidget(
      {super.key,
      required this.onCancel,
      required this.onDone,
      required this.title,
      required this.isDoneEnabled});

  final VoidCallback onCancel;
  final VoidCallback onDone;
  final bool isDoneEnabled;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            "Cancel",
            style: context.textTheme.titleMedium!.copyWith(color: context.colors.onPrimary),
          ),
        ),
        Text(
          title,
          style: context.textTheme.titleSmall!,
        ),
        TextButton(
          onPressed: isDoneEnabled ? onDone : null,
          child: Text(
            "Done",
            style: context.textTheme.titleSmall!.copyWith(color: context.colors.onPrimary),
          ),
        ),
      ],
    );
  }
}
