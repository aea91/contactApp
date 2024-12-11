import 'package:equatable/equatable.dart';
import 'package:welcome/splash/application/splash_status.dart';

class SplashState extends Equatable {
  const SplashState({required this.status});

  final SplashStatus status;

  factory SplashState.initial() => const SplashState(status: SplashStatus.initial);

  @override
  List<Object?> get props => [status];
}
