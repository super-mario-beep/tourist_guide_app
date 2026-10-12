import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsLauncher {
  Future<bool> open({
    required double latitude,
    required double longitude,
    required String label,
  }) async {
    final coordinates = '$latitude,$longitude';

    final nativeUri = defaultTargetPlatform == TargetPlatform.iOS
        ? Uri.https('maps.apple.com', '/', {'ll': coordinates, 'q': label})
        : Uri.parse('geo:$coordinates?q=$coordinates(${Uri.encodeComponent(label)})');

    if (await _launch(nativeUri)) return true;

    return _launch(
      Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': coordinates,
      }),
    );
  }

  Future<bool> _launch(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}
