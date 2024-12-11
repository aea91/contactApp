import 'package:flutter/material.dart';

extension WidgetExtension on CircularProgressIndicator {
  Widget get toCenter => const Center(child: CircularProgressIndicator.adaptive());
}
