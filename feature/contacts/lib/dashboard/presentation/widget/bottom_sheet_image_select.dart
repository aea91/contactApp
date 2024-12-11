import 'package:contacts/utils/image_source.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';

class BottomSheetImageSelect extends StatelessWidget {
  const BottomSheetImageSelect({super.key, required this.onImageSelect});

  final void Function(ImageSource? imageSource) onImageSelect;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContent(onImageSelect: onImageSelect);
  }
}

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key, required this.onImageSelect});

  final void Function(ImageSource? imageSource) onImageSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.onSurface,
        borderRadius:
            const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
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
        padding: context.paddingPage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => onImageSelect(ImageSource.camera),
              label: const Text("Camera"),
              icon: const Icon(Icons.camera_alt_outlined),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () => onImageSelect(ImageSource.gallery),
              label: const Text("Gallery"),
              icon: const Icon(Icons.image_aspect_ratio_outlined),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => GoManager.instance.pop(),
              child: const Text("Cancel"),
              style: ElevatedButton.styleFrom(
                foregroundColor: context.theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
