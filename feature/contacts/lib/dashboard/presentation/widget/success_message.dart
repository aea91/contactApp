import 'package:contacts/utils/icon_constant.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessMessage extends StatelessWidget {
  const SuccessMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: context.paddingPage,
        child: ListTile(
          leading: SvgPicture.asset(IconConstants.instance.success),
          title: Text(message,
              style: context.textTheme.titleSmall!
                  .copyWith(color: context.theme.colorScheme.onSecondary)),
        ));
  }
}
