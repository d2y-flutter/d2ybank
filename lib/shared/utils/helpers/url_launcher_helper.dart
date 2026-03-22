import 'package:url_launcher/url_launcher.dart';

abstract final class UrlLauncherHelper {
  static Future<bool> openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
  static Future<bool> openPhone(String phone) => launchUrl(Uri(scheme: 'tel', path: phone));
  static Future<bool> openEmail(String email) => launchUrl(Uri(scheme: 'mailto', path: email));
}
