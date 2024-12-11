import 'package:flutter/material.dart';

class BaseContactCard extends StatelessWidget {
  const BaseContactCard({
    super.key,
    required this.theme,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.imageUrl,
    required this.onTap,
  });

  final ThemeData theme;
  final String firstName;
  final String lastName;
  final String phone;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        visualDensity: VisualDensity.compact,
        leading: CircleAvatar(
          backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
        ),
        title: Text(
          "$firstName $lastName",
          style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(phone, style: theme.textTheme.titleSmall!.copyWith(color: theme.hintColor)),
      ),
    );
  }
}
