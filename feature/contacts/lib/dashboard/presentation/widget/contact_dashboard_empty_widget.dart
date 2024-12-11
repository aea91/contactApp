import 'package:core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ContactDashboardEmptyWidget extends StatelessWidget {
  const ContactDashboardEmptyWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 30,
          child: Icon(Icons.person, color: context.theme.scaffoldBackgroundColor),
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
