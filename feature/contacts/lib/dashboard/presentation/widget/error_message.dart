import 'package:core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
            padding: context.paddingPage,
            child: ListTile(
              leading: Icon(Icons.warning, color: context.theme.colorScheme.error),
              title: Text(
                message,
                style:
                    context.textTheme.titleSmall!.copyWith(color: context.theme.colorScheme.error),
              ),
            )),
      ),
    );
  }
}
