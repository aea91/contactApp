import 'package:core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:uikit/container/base_bottom_sheet_container.dart';

class BottomSheetDeleteAccount extends StatelessWidget {
  const BottomSheetDeleteAccount({super.key, required this.onYes, required this.onNo});

  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContent(onYes: onYes, onNo: onNo);
  }
}

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key, required this.onYes, required this.onNo});

  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetContainer(
        theme: context.theme,
        padding: context.paddingPage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Text("Delete Account",
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.titleLarge!.copyWith(
                      color: context.theme.colorScheme.error, fontWeight: FontWeight.normal)),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onYes,
              child: const Text("Yes"),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: onNo,
              child: const Text("No"),
            ),
            const SizedBox(height: 30),
          ],
        ));
  }
}
