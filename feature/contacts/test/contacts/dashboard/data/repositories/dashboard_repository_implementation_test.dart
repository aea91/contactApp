//! Yetişmedi ancak daha önceki projelerimde yazdığım testleri aşağıdaki gibidir!.

/*
class MockLoginRemoteDataSource extends Mock implements LoginRemoteDataSource {}

void main() {
  late LoginRemoteDataSource remoteDataSource;
  late LoginRepositoryImplementation repositoryImplementation;

  const device_uid = "device_uid";
  const fcm_token = "fcm_token";
  const login = "login";
  const password = "password";
  const save_login = false;

  setUp(() {
    remoteDataSource = MockLoginRemoteDataSource();
    repositoryImplementation = LoginRepositoryImplementation(remoteDataSource);
  });

  const tException = NetworkException(
    type: "type",
    message: "error",
    statusCode: 200,
  );

  group("loginUser", () {
    test(
        'should call the [RemoteDataSource.loginUSer] and complate '
        'successfully when the call to the remote source is successful', () async {
      // Arrange

      when(
        () => remoteDataSource.loginUser(
          device_uid: any(named: "device_uid"),
          fcm_token: any(named: "fcm_token"),
          login: any(named: "login"),
          password: any(named: "password"),
          save_login: any(named: "save_login"),
        ),
      ).thenAnswer((_) async => Future.value(LoginResponseModel.empty()));

      // Act

      final result = await repositoryImplementation.login(
        device_uid: device_uid,
        fcm_token: fcm_token,
        login: login,
        password: password,
        save_login: save_login,
      );

      // Assert
      expect(
          result, equals(Right<NetworkException, LoginResponseModel>(LoginResponseModel.empty())));

      verify(() => remoteDataSource.loginUser(
            device_uid: device_uid,
            fcm_token: fcm_token,
            login: login,
            password: password,
            save_login: save_login,
          )).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return a [ServerFailure] when the call to the remote source is unsuccessful',
        () async {
      // Arrange

      when(
        () => remoteDataSource.loginUser(
          device_uid: any(named: "device_uid"),
          fcm_token: any(named: "fcm_token"),
          login: any(named: "login"),
          password: any(named: "password"),
          save_login: any(named: "save_login"),
        ),
      ).thenThrow(tException);

      // Act

      final result = await repositoryImplementation.login(
        device_uid: device_uid,
        fcm_token: fcm_token,
        login: login,
        password: password,
        save_login: save_login,
      );

      // Assert
      expect(result,
          equals(Left<NetworkException, dynamic>(NetworkException.fromException(tException))));

      verify(() => remoteDataSource.loginUser(
            device_uid: device_uid,
            fcm_token: fcm_token,
            login: login,
            password: password,
            save_login: save_login,
          )).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
*/
