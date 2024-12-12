import 'package:contacts/dashboard/application/dashboard_cubit.dart';
import 'package:contacts/dashboard/application/dashboard_state.dart';
import 'package:contacts/dashboard/domain/usecase/create_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/delete_single_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/fetch_single_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/fetch_users_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/search_users_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/update_single_user.dart';
import 'package:contacts/dashboard/domain/usecase/upload_user_image.dart';
import 'package:contacts/utils/contact_go_router.dart';
import 'package:core/cache/constants/cache_keys.dart';
import 'package:core/cache/shared/shared_manager.dart';
import 'package:core/logger/contact_logger.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockCreateUserUsecase extends Mock implements CreateUserUsecase {}

class MockDeleteSingleUserUsecase extends Mock implements DeleteSingleUserUsecase {}

class MockFetchSingleUserUsecase extends Mock implements FetchSingleUserUsecase {}

class MockFetchUsersUsecase extends Mock implements FetchUsersUsecase {}

class MockSearchUsersUsecase extends Mock implements SearchUsersUsecase {}

class MockUpdateSingleUserUsecase extends Mock implements UpdateSingleUserUsecase {}

class MockUploadUserImageUsecase extends Mock implements UploadUserImageUseCase {}

void main() {
  late DashboardCubit cubit;
  late CreateUserUsecase createUserUsecase;
  late DeleteSingleUserUsecase deleteSingleUserUsecase;
  late FetchSingleUserUsecase fetchSingleUserUsecase;
  late FetchUsersUsecase fetchUsersUsecase;
  late SearchUsersUsecase searchUsersUsecase;
  late UpdateSingleUserUsecase updateSingleUserUsecase;
  late UploadUserImageUseCase uploadUserImageUseCase;

  var tCreateUserUsecaseParams = CreateUserUsecaseParams.empty();
  var tDeleteSingleUserUsecaseParams = DeleteSingleUserUsecaseParams.empty();
  var tFetchSingleUserUsecaseParams = FetchSingleUserUsecaseParams.empty();
  var tFetchUsersUsecaseParams = FetchUsersUsecaseParams.empty();
  var tSearchUsersUsecaseParams = SearchUsersUsecaseParams.empty();
  var tUpdateSingleUserUsecaseParams = UpdateSingleUserUsecaseParams.empty();
  var tUploadUserImageParams = UploadUserImageParams.empty();

  final router = GoRouter(routes: contactGoRouter);

  setUp(() async {
    createUserUsecase = MockCreateUserUsecase();
    deleteSingleUserUsecase = MockDeleteSingleUserUsecase();
    fetchSingleUserUsecase = MockFetchSingleUserUsecase();
    fetchUsersUsecase = MockFetchUsersUsecase();
    searchUsersUsecase = MockSearchUsersUsecase();
    updateSingleUserUsecase = MockUpdateSingleUserUsecase();
    uploadUserImageUseCase = MockUploadUserImageUsecase();

    registerFallbackValue(tCreateUserUsecaseParams);
    registerFallbackValue(tDeleteSingleUserUsecaseParams);
    registerFallbackValue(tFetchSingleUserUsecaseParams);
    registerFallbackValue(tFetchUsersUsecaseParams);
    registerFallbackValue(tSearchUsersUsecaseParams);
    registerFallbackValue(tUpdateSingleUserUsecaseParams);
    registerFallbackValue(tUploadUserImageParams);

    ContactLogger.instance!.init(isCacheLog: false, logDuration: Duration.zero);

    SharedPreferences.setMockInitialValues({
      CacheKeys.token.name: "42b3168e-3cfe-4ce6-99c0-7f0834339f4c",
    });

    await SharedManager.instance!.init();

    await GoManager.instance.init(router);

    cubit = DashboardCubit(
      createUser: createUserUsecase,
      deleteSingleUserUsecase: deleteSingleUserUsecase,
      fetchSingleUserUsecase: fetchSingleUserUsecase,
      fetchUsersUsecase: fetchUsersUsecase,
      searchUserUsecase: searchUsersUsecase,
      updateSingleUserUsecase: updateSingleUserUsecase,
      uploadUserImageUseCase: uploadUserImageUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test("initial state should be [DashboardState.initial]", () {
    expect(cubit.state, DashboardState.initial());
  });
}


//! Yetişmedi ancak önceki projelerden yazdığım testler aşağıdaki gibidir.
/* 
*
 * If one of the username or password or all wrong, send user to the [LoginFailView]
 * if get user login exception it means max attempt reached. Send user to the [MaxAttemptView]
 * 1. LoginState(pageEnum: idMobile, idMobile: null, password: null) => throw error id mobile can not be null
 * 2. LoginState(pageEnum: idMobile, idMobile: "email", password: null) => send loginDevice request and set the pageEnum: send_device
 * 3. LoginState(pageEnum: loginDevice, idMobile: "email", password: null) => set the pageEnum as password let user enter the password
 * 4. LoginState(pageEnum: password, idMobile: "email", password: null) => throw error password can not be null
 * 5. LoginState(pageEnum: password, idMobile: "email", password: "password") => login


class MockLoginUser extends Mock implements LoginUser {}

class MockLoginDevice extends Mock implements LoginDevice {}

void main() {
  late LoginUser loginUser;
  late LoginDevice loginDevice;
  late LoginCubit cubit;

  const tLoginUserParams = LoginUserParams.empty();
  const tLoginDeviceParams = LoginDeviceParams.empty();

  late LoginAccessLoginException tLoginFailure;
  late LoginDeviceNotFoundException tLoginDeviceFailure;

  LoginResponseModel tLoginResponse =
      LoginResponseModel.empty().copyWith(type: LoginTypes.login_success);

  final router = GoRouter(routes: []);

  setUp(() async {
    loginUser = MockLoginUser();
    loginDevice = MockLoginDevice();
    cubit = LoginCubit(loginUser: loginUser, loginDevice: loginDevice);
    registerFallbackValue(tLoginUserParams);
    registerFallbackValue(tLoginDeviceParams);

    ArpLogger.instance!.init(isCacheLog: false, logDuration: const Duration(seconds: 1));

    tLoginFailure = LoginAccessLoginException(
        exception: const NetworkException(
            type: LoginErrorTypes.accessLoginError, statusCode: 200, message: "error"));

    tLoginDeviceFailure = LoginDeviceNotFoundException(
        exception: const NetworkException(
            type: LoginDeviceErrorTypes.device_error, statusCode: 200, message: "error"));

    SharedPreferences.setMockInitialValues({CacheKeys.user.name: tLoginResponse.toJson()});

    await SharedManager.instance!.init();

    await GoManager.instance.init(router);
  });

  tearDown(() => cubit.close());

  test("initial state should be [LoginInitial]", () async {
    expect(cubit.state.stateEnum, equals(LoginStateEnum.initial));
  });

  blocTest<LoginCubit, LoginState>(
      "[clearException] should clear the [NetworkException] when it is called",
      build: () {
        return cubit;
      },
      act: (bloc) {
        cubit.emit(LoginState.initial().copyWith(exception: tLoginFailure));
        cubit.clearException();
      },
      expect: () => [
            LoginState.initial().copyWith(exception: tLoginFailure),
            LoginState.initial().copyWith(exception: const AppException()),
          ]);

  blocTest<LoginCubit, LoginState>(
      "[changeTheLanguage] should change the language [CountryModel] when it is called",
      build: () {
        cubit.state.copyWith(selectedLanguage: null);
        return cubit;
      },
      act: (bloc) {
        cubit.emit(LoginState.initial().copyWith(selectedLanguage: null));
        cubit.changeTheLanguage(selectedLanguage: CountryModel.empty());
      },
      expect: () => [
            LoginState.initial().copyWith(selectedLanguage: null),
            LoginState.initial().copyWith(selectedLanguage: CountryModel.empty()),
          ]);

  blocTest<LoginCubit, LoginState>(
      "[setRememberMe] should set the rememberMe value in given boolean value",
      build: () {
        return cubit;
      },
      act: (bloc) {
        cubit.emit(LoginState.initial().copyWith(isRememberMe: false));
        cubit.setRememberMe(true);
      },
      expect: () => [
            LoginState.initial().copyWith(isRememberMe: false),
            LoginState.initial().copyWith(isRememberMe: true),
          ]);

  group("setIdMobile", () {
    blocTest<LoginCubit, LoginState>("when idMobile is null and user start to typing",
        build: () {
          return cubit;
        },
        act: (bloc) {
          cubit.emit(LoginState.initial().copyWith(idMobile: null, isButtonEnable: false));
          cubit.setIdMobile(value: "value");
        },
        expect: () => [
              LoginState.initial().copyWith(idMobile: null, isButtonEnable: false),
              LoginState.initial().copyWith(idMobile: "value", isButtonEnable: true),
            ]);

    blocTest<LoginCubit, LoginState>("when idMobile has a value and user delete it",
        build: () {
          return cubit;
        },
        act: (bloc) {
          cubit.emit(LoginState.initial().copyWith(idMobile: "value", isButtonEnable: true));
          cubit.setIdMobile(value: "");
        },
        expect: () => [
              LoginState.initial().copyWith(idMobile: "value", isButtonEnable: true),
              LoginState.initial().copyWith(idMobile: "", isButtonEnable: false),
            ]);
  });

  group("setPassword", () {
    blocTest<LoginCubit, LoginState>("when password is empty and user start to typing",
        build: () {
          return cubit;
        },
        act: (cubit) {
          cubit.emit(LoginState.initial().copyWith(password: null, isButtonEnable: false));
          cubit.setPassword(value: "value");
        },
        expect: () => [
              LoginState.initial().copyWith(password: null, isButtonEnable: false),
              LoginState.initial().copyWith(password: "value", isButtonEnable: true),
            ]);

    blocTest<LoginCubit, LoginState>("when password has a value and user delete it",
        build: () {
          return cubit;
        },
        act: (cubit) {
          cubit.emit(LoginState.initial().copyWith(password: "value", isButtonEnable: true));
          cubit.setPassword(value: "");
        },
        expect: () => [
              LoginState.initial().copyWith(password: "value", isButtonEnable: true),
              LoginState.initial().copyWith(password: "", isButtonEnable: false),
            ]);
  });

  blocTest<LoginCubit, LoginState>("[enableButton] should set the [isButtonEnable] value as true",
      build: () {
        return cubit;
      },
      act: (cubit) {
        cubit.emit(LoginState.initial().copyWith(isButtonEnable: false));
        cubit.enableButton();
      },
      expect: () => [
            LoginState.initial().copyWith(isButtonEnable: false),
            LoginState.initial().copyWith(isButtonEnable: true),
          ]);

  blocTest<LoginCubit, LoginState>("[disableButton] should set the [isButtonEnable] value as false",
      build: () {
        return LoginCubit(loginUser: loginUser, loginDevice: loginDevice);
      },
      act: (cubit) {
        cubit.emit(LoginState.initial().copyWith(isButtonEnable: true));
        cubit.disableButton();
      },
      expect: () => [
            LoginState.initial().copyWith(isButtonEnable: true),
            LoginState.initial().copyWith(isButtonEnable: false),
          ]);

  group("funcContinue for idMobile page", () {
    blocTest<LoginCubit, LoginState>(
      "1. LoginState(pageEnum: idMobile, idMobile: null, password: null) => throw error id mobile can not be null",
      build: () {
        return cubit;
      },
      act: (cubit) {
        return cubit.funcContinue();
      },
      expect: () => [
        LoginState.initial()
            .copyWith(idMobile: null, password: null, exception: LoginIdMobileMissingException()),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      "2. LoginState(pageEnum: idMobile, idMobile: email, password: null) => send loginDevice request and set the pageEnum: send_device"
      "Success Scenerio",
      build: () {
        when(() => loginDevice(any())).thenAnswer((_) async =>
            Right<NetworkException, LoginResponseModel>(
                tLoginResponse.copyWith(access_token: "access_token")));
        return cubit;
      },
      act: (cubit) {
        cubit.emit(LoginState.initial().copyWith(
          pageEnum: LoginPageEnum.id_mobile,
          idMobile: "email",
          password: null,
        ));
        return cubit.loginDevice(username: "email", device_uid: "device_uid");
      },
      expect: () => [
        LoginState.initial().copyWith(
          stateEnum: LoginStateEnum.initial,
          pageEnum: LoginPageEnum.id_mobile,
          idMobile: "email",
          password: null,
        ),
        LoginState.initial().copyWith(
          stateEnum: LoginStateEnum.loading,
          pageEnum: LoginPageEnum.id_mobile,
          idMobile: "email",
          password: null,
        ),
        LoginState.initial().copyWith(
          stateEnum: LoginStateEnum.complated,
          pageEnum: LoginPageEnum.id_mobile,
          idMobile: "email",
          password: null,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      "3. LoginState(pageEnum: idMobile, idMobile: email, password: null) => send loginDevice request and set the pageEnum: send_device"
      "Fail Scenerio",
      build: () {
        when(() => loginDevice(any())).thenAnswer((_) async => Left(tLoginDeviceFailure));
        return cubit;
      },
      act: (cubit) {
        cubit.emit(LoginState.initial().copyWith(
          pageEnum: LoginPageEnum.id_mobile,
          idMobile: "email",
          password: null,
        ));
        return cubit.loginDevice(username: "email", device_uid: "device_uid");
      },
      expect: () => [
        LoginState.initial().copyWith(
          stateEnum: LoginStateEnum.initial,
          pageEnum: LoginPageEnum.id_mobile,
          idMobile: "email",
          password: null,
        ),
        LoginState.initial().copyWith(
          stateEnum: LoginStateEnum.loading,
          pageEnum: LoginPageEnum.id_mobile,
          idMobile: "email",
          password: null,
        ),
        LoginState.initial().copyWith(
          stateEnum: LoginStateEnum.error,
          pageEnum: LoginPageEnum.login_device,
          idMobile: "email",
          password: null,
          exception: tLoginDeviceFailure,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      "4. LoginState(pageEnum: loginDevice, idMobile: email, password: null) => set the pageEnum as password let user enter the password",
      build: () {
        return cubit;
      },
      act: (cubit) {
        cubit.emit(LoginState.initial().copyWith(
          pageEnum: LoginPageEnum.login_device,
          idMobile: "email",
          password: null,
        ));
        return cubit.funcContinue();
      },
      expect: () => [
        LoginState.initial()
            .copyWith(pageEnum: LoginPageEnum.login_device, idMobile: "email", password: null),
        LoginState.initial()
            .copyWith(pageEnum: LoginPageEnum.password, idMobile: "email", password: null)
      ],
    );

    blocTest<LoginCubit, LoginState>(
      "5. LoginState(pageEnum: password, idMobile: email, password: null) => throw error password can not be null",
      build: () {
        return cubit;
      },
      act: (cubit) {
        cubit.emit(LoginState.initial().copyWith(
          pageEnum: LoginPageEnum.password,
          idMobile: "email",
          password: null,
        ));
        return cubit.funcContinue();
      },
      expect: () => [
        LoginState.initial()
            .copyWith(pageEnum: LoginPageEnum.password, idMobile: "email", password: null),
        LoginState.initial().copyWith(
          pageEnum: LoginPageEnum.password,
          idMobile: "email",
          password: null,
          exception: LoginPasswordMissingException(),
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      "6. LoginState(pageEnum: password, idMobile: email, password: password) => login"
      "Success Scenerio",
      build: () {
        when(() => loginDevice(any())).thenAnswer((_) async =>
            Right<NetworkException, LoginResponseModel>(
                tLoginResponse.copyWith(access_token: "access_token")));
        return cubit;
      },
      act: (cubit) {
        cubit.emit(LoginState.initial().copyWith(
          pageEnum: LoginPageEnum.password,
          idMobile: "email",
          password: "password",
        ));
        return cubit.loginDevice(username: "email", device_uid: "device_uid");
      },
      expect: () => [
        LoginState.initial().copyWith(
          stateEnum: LoginStateEnum.initial,
          pageEnum: LoginPageEnum.password,
          idMobile: "email",
          password: "password",
        ),
        LoginState.initial().copyWith(
          stateEnum: LoginStateEnum.loading,
          pageEnum: LoginPageEnum.password,
          idMobile: "email",
          password: "password",
        ),
        LoginState.initial().copyWith(
          stateEnum: LoginStateEnum.complated,
          pageEnum: LoginPageEnum.password,
          idMobile: "email",
          password: "password",
        ),
      ],
    );
  });
} */