import 'package:core/base/view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome/splash/application/splash_cubit.dart';
import 'package:welcome/splash/application/splash_state.dart';
import 'package:welcome/utils/injection_contatiner.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashCubit>()..init(),
      child: BlocConsumer<SplashCubit, SplashState>(
        builder: (context, state) {
          return const BaseView(body: Center(child: CircularProgressIndicator.adaptive()));
        },
        listener: (context, state) {},
      ),
    );
  }
}
