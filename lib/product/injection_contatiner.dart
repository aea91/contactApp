import 'package:contact/env/app_env.dart';
import 'package:contact/product/go_routes.dart';
import 'package:core/cache/constants/cache_keys.dart';
import 'package:core/cache/shared/shared_manager.dart';
import 'package:core/logger/contact_logger.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:core/network/network_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:packages/image_picker/image_picker_manager.dart';

final sl = GetIt.instance;

Future<void> mainInit() async {
  await SharedManager.instance!.init();
  await SharedManager.instance!.saveStringValue(CacheKeys.token.name, AppEnv().token);
  GoManager.instance.init(router);
  ContactLogger.instance!.init(isCacheLog: true, logDuration: Duration(seconds: 10));
  ImagePickerManager.instance!.init();
  NetworkManager.instance!.init(
    baseUrl: AppEnv().baseUrl,
    sendTimeOut: 10,
    connectTimeOut: 10,
    receiveTimeOut: 10,
  );
}
