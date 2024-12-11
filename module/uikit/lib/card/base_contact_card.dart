import 'package:flutter/material.dart';

class BaseContactCard extends StatelessWidget {
  const BaseContactCard({
    super.key,
    required this.theme,
    required this.name,
    required this.phone,
    required this.imageUrl,
    required this.onTap,
  });

  final ThemeData theme;
  final String name;
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
          backgroundImage: NetworkImage(imageUrl),
        ),
        title:
            Text(name, style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(phone, style: theme.textTheme.titleSmall!.copyWith(color: theme.hintColor)),
      ),
    );
  }
}
