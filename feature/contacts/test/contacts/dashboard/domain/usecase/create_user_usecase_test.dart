//! Yetişmedi ancak daha önceki projelerimde yazdığım testleri aşağıdaki gibidir!.

/*

void main() {
  late LoginUser useCaseLoginUser;
  late LoginDevice useCaseLoginDevice;
  late LoginRepository _repository;

  setUpAll(() {
    _repository = MockLoginRepo();
    useCaseLoginUser = LoginUser(_repository);
    useCaseLoginDevice = LoginDevice(_repository);
  });

  const params = LoginUserParams.empty();

  const loginDeviceParams = LoginDeviceParams.empty();

  test('should call the [LoginRepo.loginUser]', () async {
    final response = LoginResponseModel.empty();

    // Arrange
    when(() => _repository.login(
          device_uid: any(named: "device_uid"),
          fcm_token: any(named: "fcm_token"),
          login: any(named: "login"),
          password: any(named: "password"),
          save_login: any(named: "save_login"),
        )).thenAnswer((_) async => Right(response));

    // Act
    final result = await useCaseLoginUser(params);

    // Assert
    expect(result, equals(Right<void, LoginResponseModel>(response)));

    verify(() => _repository.login(
        device_uid: params.device_uid,
        fcm_token: params.fcm_token,
        login: params.login,
        password: params.password,
        save_login: params.save_login)).called(1);

    verifyNoMoreInteractions(_repository);
  });

  test('should call the [LoginRepo.loginUser]', () async {
    final response = LoginResponseModel.empty();

    // Arrange
    when(() => _repository.loginDevice(
          device_uid: any(named: "device_uid"),
          username: any(named: "username"),
        )).thenAnswer((_) async => Right(response));

    // Act
    final result = await useCaseLoginDevice(loginDeviceParams);

    // Assert
    expect(result, equals(Right<void, LoginResponseModel>(response)));

    verify(() => _repository.loginDevice(
          device_uid: loginDeviceParams.device_uid,
          username: loginDeviceParams.username,
        )).called(1);

    verifyNoMoreInteractions(_repository);
  });
}
*/