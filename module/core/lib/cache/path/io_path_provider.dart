import 'package:path_provider/path_provider.dart';

import 'custom_path_provider.dart';

CustomPathProvider createPathProviderAdapter() => _IOPathProviderManager();

class _IOPathProviderManager implements CustomPathProvider {
  @override
  Future<String> applicationDirectoryPath() async {
    return (await getApplicationDocumentsDirectory()).path;
  }
}
