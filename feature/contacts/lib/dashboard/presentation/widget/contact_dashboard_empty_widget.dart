import 'package:contacts/utils/icon_constant.dart';
import 'package:core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContactDashboardEmptyWidget extends StatelessWidget {
  const ContactDashboardEmptyWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          IconConstants.instance.person,
          width: 60,
          height: 60,
        ),
        SizedBox(height: 15),
        Text(
          "No Contacts",
          style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Text(
          "Contacts you've added will appear here.",
          style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text("Create New Contact",
              style: context.textTheme.titleSmall!.copyWith(
                color: context.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              )),
        )
      ],
    );
  }
}
