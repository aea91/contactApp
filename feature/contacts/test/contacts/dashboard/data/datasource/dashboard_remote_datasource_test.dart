//! Yetişmedi ancak daha önceki projelerimde yazdığım testleri aşağıdaki gibidir!.

/*
class MockClient extends Mock implements InterfaceNetworkManager {}

void main() {
  late MockClient manager;
  late LoginRemoteDataSource remoteDataSource;

  setUp(() async {
    MockClient().init(
      baseUrl: "https://devapi.armancoders.com",
      sendTimeOut: 50,
      connectTimeOut: 50,
      receiveTimeOut: 50,
    );

    manager = MockClient();

    remoteDataSource = LoginRemoteDataSouceImplementation(manager);
  });

  group("login", () {
    test("should complate successfully when the answer is success", () async {
      when(() => manager.dioPost(
            path: any(named: "path"),
            model: any(named: "model"),
            fromJson: any(named: "fromJson"),
          )).thenAnswer((_) async => LoginResponseModel.empty());

      final methodCall = remoteDataSource.loginUser(
          device_uid: "device_uid",
          fcm_token: "fcm_token",
          login: "login",
          password: "password",
          save_login: false);

      expect(methodCall, completes);

      verify(
        () => manager.dioPost(
            path: NetworkConstants.login.login,
            model: const LoginUserParams(
              device_uid: "device_uid",
              fcm_token: "fcm_token",
              login: "login",
              password: "password",
              save_login: false,
            ),
            fromJson: LoginResponseModel.fromJson),
      ).called(1);

      verifyNoMoreInteractions(manager);
    });

    test("should throws a [NetworkException]", () async {
      when(() => manager.dioPost(
            path: any(named: "path"),
            model: any(named: "model"),
            fromJson: any(named: "fromJson"),
          )).thenAnswer((_) async => const NetworkException(
            type: "type",
            message: "error",
            statusCode: 200,
          ));

      final methodCall = remoteDataSource.loginUser;

      expect(
          () => methodCall(
                device_uid: "device_uid",
                fcm_token: "fcm_token",
                login: "login",
                password: "password",
                save_login: false,
              ),
          throwsA(const NetworkException(
            type: "type",
            message: "error",
            statusCode: 200,
          )));

      verify(
        () => manager.dioPost(
            path: NetworkConstants.login.login,
            model: const LoginUserParams(
              device_uid: "device_uid",
              fcm_token: "fcm_token",
              login: "login",
              password: "password",
              save_login: false,
            ),
            fromJson: LoginResponseModel.fromJson),
      ).called(1);

      verifyNoMoreInteractions(manager);
    });
  });
}*/