import 'package:url_launcher/url_launcher.dart';

class LauncherManager {
  static LauncherManager? _instance;
  static LauncherManager get instance {
    _instance ??= LauncherManager._init();
    return _instance!;
  }

  LauncherManager._init();

  Future<bool> canCallNumber({required String phoneNumber}) {
    return canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber));
  }

  Future<void> makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> goWebsite({required String url}) async {
    String scheme;
    if (url.contains('https')) {
      scheme = "https";
      url = url.replaceAll("https://", "");
    } else if (url.contains('http')) {
      scheme = "http";
      url = url.replaceAll("http", "");
    } else {
      scheme = "https";
    }

    final Uri lauchUri = Uri(
      scheme: scheme,
      path: url,
    );
    await launchUrl(lauchUri);
  }

  Future<void> mailTo({required String mail}) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: mail,
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
