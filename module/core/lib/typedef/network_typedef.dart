import 'package:core/base/model/network_error.dart';
import 'package:fpdart/fpdart.dart';

typedef ResultFuture<T> = Future<Either<NetworkException, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef DataMap = Map<String, dynamic>;
