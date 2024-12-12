import 'package:contacts/utils/icon_constant.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uikit/container/base_bottom_sheet_container.dart';

class MessageService {
  static final MessageService _instance = MessageService._internal();
  factory MessageService() => _instance;
  MessageService._internal();

  static OverlayState? _overlayState;
  static OverlayEntry? _overlayEntry;

  static void init(BuildContext context) {
    _overlayState = Overlay.of(context);
  }

  static void showMessage({
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (_overlayState == null) return;

    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: isError ? _ErrorMessage(message: message) : _SuccessMessage(message: message),
        ),
      ),
    );

    _overlayState?.insert(_overlayEntry!);

    Future.delayed(duration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}

class _SuccessMessage extends StatelessWidget {
  const _SuccessMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetContainer(
      child: ListTile(
        leading: SvgPicture.asset(IconConstants.instance.success),
        title: Text(message,
            style: context.textTheme.titleSmall!
                .copyWith(color: context.theme.colorScheme.onSecondary)),
      ),
      theme: context.theme,
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetContainer(
      theme: context.theme,
      child: ListTile(
        leading: Icon(Icons.error),
        title: Text(message,
            style: context.textTheme.titleSmall!.copyWith(color: context.theme.colorScheme.error)),
      ),
    );
  }
}
