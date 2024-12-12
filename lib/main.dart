import 'package:contact/product/injection_contatiner.dart';
import 'package:contact/product/message_service.dart';
import 'package:contacts/utils/injection_contatiner.dart';
import 'package:core/exception/exception_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global/application/global_cubit.dart';
import 'package:global/application/global_state.dart';
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
    return BlocProvider(
      create: (context) => GlobalCubit(),
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {
          if (state.exception != null && state.exception!.message!.isNotEmpty) {
            MessageService.showMessage(
              message: state.exception!.message ?? '',
              isError: state.exception!.type != ExceptionType.info,
            );
            context.read<GlobalCubit>().clearException();
          }
        },
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Flutter App Test Case',
            debugShowCheckedModeBanner: false,
            theme: ContactTheme,
            routerConfig: router,
            builder: (context, child) {
              return Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) {
                      MessageService.init(context);
                      return child ?? const SizedBox();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
