import 'dart:io';
import 'package:core/base/model/network_error.dart';
import 'package:core/base/model/base_response_model.dart';
import 'package:core/cache/shared/shared_manager.dart';
import 'package:core/exception/exception_type.dart';
import 'package:core/logger/contact_logger.dart';
import 'package:core/network/interface_network_manager.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../navigation/go_manager.dart';

class NetworkManager implements InterfaceNetworkManager {
  // ignore: non_constant_identifier_names
  final String TAG = "NetworkManager";
  late Dio _dio;
  static NetworkManager? _instance;
  static NetworkManager? get instance {
    _instance ??= NetworkManager._init();
    return _instance!;
  }

  NetworkManager._init();

  @override
  init({
    required String baseUrl,

    /// send timeout seconds
    required int sendTimeOut,

    /// connect timeOut seconds
    required int connectTimeOut,

    /// receive time out seconds
    required int receiveTimeOut,
  }) {
    final baseOptions = BaseOptions(
      baseUrl: baseUrl,
      sendTimeout: Duration(seconds: sendTimeOut),
      connectTimeout: Duration(seconds: connectTimeOut),
      receiveTimeout: Duration(seconds: receiveTimeOut),
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status! < 401;
      },
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    );
    _dio = Dio(baseOptions);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioException` using `handler.reject(dioError)`.
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioException` object using `handler.reject(dioError)`.
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          ContactLogger.instance!.error(TAG,
              "baseUrl: ${e.requestOptions.baseUrl} path: ${e.requestOptions.path} params: ${e.requestOptions.queryParameters} statusCode: ${e.response?.statusCode} error: ${e.error} message: ${e.message}");
          switch (e.response?.statusCode) {
            case HttpStatus.unprocessableEntity:
              return handler.resolve(e.response!);
            case HttpStatus.badRequest:
              return handler.resolve(e.response!);
            case HttpStatus.unauthorized:
              await SharedManager.instance!.removeAll();
              ContactLogger.instance!.error(TAG,
                  "baseUrl: ${e.requestOptions.baseUrl} path: ${e.requestOptions.path} header: ${e.requestOptions.headers}");
              GoManager.instance.go(path: '/login_view');
            default:
              if (e is HttpException) {
                GoManager.instance.replace(
                    path: "/network_error_view",
                    data: '${e.response?.statusCode} path: ${e.requestOptions.path} ${e.message}');
              } else {
                GoManager.instance.replace(
                    path: "/network_error_view",
                    data: '${e.response?.statusCode}  path: ${e.requestOptions.path}');
              }

              break;
          }

          return handler.next(e);
        },
      ),
    );

    // Dio Certificate Exception Solution
    // ignore: deprecated_member_use
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  @override
  Future<dynamic> dioGet(
      {required String path,
      String? token,
      Map<String, dynamic>? queryParam,
      required Function(Map<String, dynamic> json) fromJson}) async {
    print("get request");
    try {
      _setHeaders(token);
      queryParam = _cleanNullParams(queryParam);

      final response = await _dio.get(path, queryParameters: queryParam);
      return _handleResponse(response: response, fromJson: fromJson);
    } on DioException catch (e) {
      await _handleError(e);
      rethrow;
    }
  }

  /// Ortak response işleme metodu
  Future<T?> _handleResponse<T>({
    required Response response,
    required Function(Map<String, dynamic> json)? fromJson,
  }) async {
    final responseBody = response.data;
    ContactLogger.instance?.info(TAG, 'response: $responseBody');

    final baseResponse = BaseResponseModel.fromJson(responseBody);

    if (baseResponse.status == HttpStatus.ok) {
      if (fromJson == null) return null;

      final data = baseResponse.data;
      if (data == null) return null;

      if (data is List) {
        return data.map((e) => fromJson(e)).toList() as T;
      } else if (data is Map) {
        return fromJson(data as Map<String, dynamic>) as T;
      }
      return data as T;
    }

    throw NetworkException(
      message: baseResponse.messages?.firstOrNull,
      statusCode: response.statusCode ?? -1,
      type: ExceptionType.error,
    );
  }

  /// Merkezi hata yönetimi
  Future<void> _handleError(DioException e) async {
    ContactLogger.instance?.error(
        TAG,
        'Error: ${e.response?.statusCode} - ${e.requestOptions.path}\n'
        'Params: ${e.requestOptions.queryParameters}\n'
        'Message: ${e.message}');

    switch (e.response?.statusCode) {
      case HttpStatus.unauthorized:
        await SharedManager.instance?.removeAll();
        GoManager.instance.go(path: '/login_view');
        break;
      default:
        final errorMessage = e is HttpException
            ? '${e.response?.statusCode} path: ${e.requestOptions.path} ${e.message}'
            : '${e.response?.statusCode} path: ${e.requestOptions.path}';
        GoManager.instance.replace(path: "/network_error_view", data: errorMessage);
    }
  }

  // Yardımcı metodlar
  void _setHeaders(String? token) {
    if (token != null) {
      _dio.options.headers['ApiKey'] = token;
    }
    _dio.options.responseType = ResponseType.json;
  }

  Map<String, dynamic>? _cleanNullParams(Map<String, dynamic>? params) {
    if (params == null) return null;
    return Map.fromEntries(params.entries.where((entry) => entry.value != null));
  }

  @override
  Future dioPost({
    required String path,
    required dynamic model,
    String? token,
    int? deviceId,
    required Function(Map<String, dynamic> json)? fromJson,
    bool isSendResponseDirect = false,
    Map<String, dynamic>? queryParam,
  }) async {
    if (token != null) _dio.options.headers['Authorization'] = 'Bearer $token';
    _dio.options.responseType = ResponseType.json;

    if (queryParam != null) {
      queryParam = Map.fromEntries(queryParam.entries.where((entry) => entry.value != null));
    }

    ContactLogger.instance!.info(TAG, "access token: $token");
    ContactLogger.instance!.info(TAG, "deviceId: $deviceId");
    var json;
    if (model != null) {
      json = model.toJson();
    }

    ContactLogger.instance!.warning(TAG, "json: $json");

    var response = await _dio.post(path, data: json, queryParameters: queryParam);

    ContactLogger.instance!.info(TAG, 'post path: $path status: ${response.statusCode}');
    final responseBody = response.data;
    ContactLogger.instance!.info(TAG, 'response: $responseBody');

    BaseResponseModel baseResponse = BaseResponseModel.fromJson(responseBody);

    if (baseResponse.status == HttpStatus.ok) {
      if (fromJson == null) return null;

      final data = baseResponse.data;
      if (data is List) {
        ContactLogger.instance!.info(TAG, "data is list");
        return data.map((e) => fromJson(e)).toList();
      } else if (data is Map) {
        ContactLogger.instance!.info(TAG, "data is map");
        return fromJson(data as Map<String, dynamic>);
      } else {
        return data;
      }
    } else {
      return NetworkException(
        message: baseResponse.messages?.first,
        statusCode: response.statusCode!,
        type: ExceptionType.error,
      );
    }
  }

  @override
  Future dioPut({
    required String path,
    required model,
    required String token,
    int? deviceId,
    Map<String, dynamic>? queryParam,
    required Function(Map<String, dynamic> json)? fromJson,
  }) async {
    _dio.options.headers['Authorization'] = "Bearer $token";
    _dio.options.responseType = ResponseType.json;

    if (queryParam != null) {
      queryParam = Map.fromEntries(queryParam.entries.where((entry) => entry.value != null));
    }

    Map<String, dynamic>? json;

    if (model != null) {
      json = model.toJson();

      json = Map.fromEntries(json!.entries.where((entry) => entry.value != null));

      ContactLogger.instance!.warning(TAG, "json: $json");
    }

    ContactLogger.instance!.info(TAG, 'put path: $path queryParam: $queryParam json: $json');

    var response = await _dio.put(path, data: json, queryParameters: queryParam);

    ContactLogger.instance!.info(TAG, "statusCode: ${response.statusCode} fromJson $fromJson");

    ContactLogger.instance!.info(TAG, 'status: ${response.statusCode}');
    final responseBody = response.data;
    ContactLogger.instance!.info(TAG, 'response: $responseBody');

    BaseResponseModel baseResponse = BaseResponseModel.fromJson(responseBody);

    if (baseResponse.status == HttpStatus.ok) {
      if (fromJson == null) return null;

      final data = baseResponse.data;
      if (data is List) {
        ContactLogger.instance!.info(TAG, "data is list");
        return data.map((e) => fromJson(e)).toList();
      } else if (data is Map) {
        ContactLogger.instance!.info(TAG, "data is map");
        return fromJson(data as Map<String, dynamic>);
      } else {
        return data;
      }
    } else {
      return NetworkException(
        message: baseResponse.messages?.first,
        type: ExceptionType.error,
        statusCode: response.statusCode!,
      );
    }
  }

  @override
  Future postForm({
    required String path,
    required FormData formData,
    required String token,
    required Function(Map<String, dynamic> json)? fromJson,
  }) async {
    _dio.options.headers['Authorization'] = "Bearer $token";
    _dio.options.responseType = ResponseType.json;

    var response = await _dio.post(
      path,
      data: formData,
    );

    final responseBody = response.data;

    BaseResponseModel baseResponse = BaseResponseModel.fromJson(responseBody);

    if (baseResponse.status == HttpStatus.ok) {
      if (fromJson == null) return null;
      final data = baseResponse.data;
      return fromJson(data as Map<String, dynamic>);
    } else {
      return NetworkException(
        message: baseResponse.messages?.first,
        type: ExceptionType.error,
        statusCode: response.statusCode!,
      );
    }
  }

  @override
  Future dioDelete({
    required String path,
    required Function(Map<String, dynamic> json)? fromJson,
    required String token,
    int? deviceId,
    Map<String, dynamic>? queryParam,
  }) async {
    _dio.options.headers['Authorization'] = "Bearer $token";
    _dio.options.responseType = ResponseType.json;

    if (queryParam != null) {
      queryParam = Map.fromEntries(queryParam.entries.where((entry) => entry.value != null));
    }

    ContactLogger.instance!.warning(TAG, "path: $path queryParam: $queryParam ");

    var response = await _dio.delete(path, queryParameters: queryParam);
    final responseBody = response.data;
    BaseResponseModel baseResponse = BaseResponseModel.fromJson(responseBody);

    if (baseResponse.status == HttpStatus.ok) {
      if (fromJson == null) return null;
      final data = baseResponse.data;
      if (data is List) {
        ContactLogger.instance!.info(TAG, "data is list");
        return data.map((e) => fromJson(e)).toList();
      } else if (data is Map) {
        ContactLogger.instance!.info(TAG, "data is map");
        return fromJson(data as Map<String, dynamic>);
      } else {
        return data;
      }
    } else {
      return NetworkException(
        message: baseResponse.messages?.first,
        type: ExceptionType.error,
        statusCode: response.statusCode!,
      );
    }
  }

  Future<Response> downloadImage({required String imageUrl}) async {
    _dio.options.responseType = ResponseType.bytes;
    _dio.options.followRedirects = false;
    Response response = await _dio.get(imageUrl);

    return response;
  }
}
