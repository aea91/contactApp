import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkManager {
  // singleton lazy pattern
  static CachedNetworkManager? _instance;
  CachedNetworkManager._init();

  static CachedNetworkManager? get instance {
    _instance ??= CachedNetworkManager._init();
    return _instance;
  }

  Future init(String url) async {}

  Widget cachedNetworkImage({
    required String imageUrl,
    required String errorImagePath,
    required double width,
    required double height,
    BoxFit? fit,
  }) {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(
        imageUrl,
        cacheKey: imageUrl,
        errorListener: (failure) {
          Image.asset(errorImagePath);
        },
      ),
    );
  }
}
