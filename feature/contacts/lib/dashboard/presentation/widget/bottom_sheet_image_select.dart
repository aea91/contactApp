import 'package:contacts/utils/icon_constant.dart';
import 'package:contacts/utils/image_source.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uikit/container/base_bottom_sheet_container.dart';

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
    return BaseBottomSheetContainer(
        theme: context.theme,
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
                icon: SvgPicture.asset(IconConstants.instance.camera, width: 24, height: 24),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () => onImageSelect(ImageSource.gallery),
                label: const Text("Gallery"),
                icon: SvgPicture.asset(IconConstants.instance.gallery, width: 24, height: 24),
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
        ));
  }
}
