import 'package:contact/product/injection_contatiner.dart';
import 'package:contacts/utils/injection_contatiner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:core/theme/theme.dart';
import 'package:welcome/utils/injection_contatiner.dart';

import 'product/go_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Future.wait([
    mainInit(),
    getItWelcomeInit(),
    getItContactsInit(),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App Test Case',
      debugShowCheckedModeBanner: false,
      theme: ContactTheme,
      routerConfig: router,
    );
  }
}
