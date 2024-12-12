//! Yetişmedi ancak daha önceki projelerimde yazdığım testleri aşağıdaki gibidir!.

/*
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> getItSetUpLogin(LoginDevice _loginDevice, LoginUser _loginUser) async {
    if (sl.isRegistered<LoginCubit>()) {
      await sl.unregister<LoginCubit>();
      await sl.unregister<LoginUser>();
      await sl.unregister<LoginDevice>();
      await sl.unregister<LoginRepository>();
      await sl.unregister<LoginRemoteDataSource>();
    }
    sl
      ..registerFactory(() => LoginCubit(loginUser: _loginUser, loginDevice: _loginDevice))
      ..registerLazySingleton(() => LoginUser(sl()))
      ..registerLazySingleton(() => LoginDevice(sl()))
      ..registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation(sl()))
      ..registerLazySingleton<LoginRemoteDataSource>(
          () => LoginRemoteDataSouceImplementation(NetworkManager.instance!));
  }

  late LoginDevice _loginDevice;
  late LoginUser _loginUser;

  final tLoginDeviceParams = LoginDeviceParams.empty();
  final tLoginUserParams = LoginUserParams.empty();

  late LoginDeviceNotFoundException tLoginDeviceNotFoundException;

  setUp(() {
    _loginDevice = MockIntegrationTestLoginDevice();
    _loginUser = MockIntegrationTestLoginUser();
    registerFallbackValue(tLoginUserParams);
    registerFallbackValue(tLoginDeviceParams);
    getItSetUpLogin(_loginDevice, _loginUser);

    ArpLogger.instance!.init(isCacheLog: false, logDuration: Duration(days: 1));

    tLoginDeviceNotFoundException = tLoginDeviceNotFoundException = LoginDeviceNotFoundException(
        exception: NetworkException(
            type: LoginDeviceErrorTypes.device_error, statusCode: 200, message: "message"));
  });

  testWidgets(
      "login user mfa"
      "user has only one mfa example: [MfaType.otp]"
      "should send the user to the [OtpView] directly", (tester) async {
    when(() => _loginDevice(any()))
        .thenAnswer((invocation) async => Left(tLoginDeviceNotFoundException));
    when(() => _loginUser(any())).thenAnswer((_) async => Right(LoginResponseModel.empty().copyWith(
          type: LoginTypes.mfa,
          active_mfa: [MfaTypes.totp],
          access_token: "access_token",
          pre_login: "pre_login",
        )));

    await app.main();

    await tester.pumpAndSettle();

    final Finder usernameField = find.byKey(Key("idmobile"));

    await tester.enterText(usernameField, "example@cloud4u.com");

    await tester.pump();

    final Finder buttonContinue = find.byType(PrimaryButtonIcon);

    await tester.tap(buttonContinue);

    await Future.delayed(Duration(seconds: 1));

    final Finder passwordField = find.byType(BaseTextField);

    await tester.enterText(passwordField, "password");

    await tester.pump();

    final Finder buttonContinueLogin = find.byType(PrimaryButtonIcon);

    await tester.tap(buttonContinueLogin);

    await Future.delayed(Duration(seconds: 1));

    expect(find.byType(OtpView), findsOneWidget);
  });

  testWidgets(
      "login user mfa"
      "user has more than one mfa"
      "should send the user to the [MfaSelectionView] directly", (tester) async {
    when(() => _loginDevice(any()))
        .thenAnswer((invocation) async => Left(tLoginDeviceNotFoundException));
    when(() => _loginUser(any())).thenAnswer((_) async => Right(LoginResponseModel.empty().copyWith(
          type: LoginTypes.mfa,
          active_mfa: [MfaTypes.totp, MfaTypes.mail],
          access_token: "access_token",
          pre_login: "pre_login",
        )));

    await app.main();

    await tester.pumpAndSettle();

    final Finder usernameField = find.byKey(Key("idmobile"));

    await tester.enterText(usernameField, "example@cloud4u.com");

    await tester.pump();

    final Finder buttonContinue = find.byType(PrimaryButtonIcon);

    await tester.tap(buttonContinue);

    await Future.delayed(Duration(seconds: 1));

    final Finder passwordField = find.byType(BaseTextField);

    await tester.enterText(passwordField, "password");

    await tester.pump();

    final Finder buttonContinueLogin = find.byType(PrimaryButtonIcon);

    await tester.tap(buttonContinueLogin);

    await Future.delayed(Duration(seconds: 1));

    expect(find.byType(MfaSelectionView), findsOneWidget);
  });
}
*/