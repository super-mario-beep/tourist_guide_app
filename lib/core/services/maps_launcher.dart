import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a location in the platform's default maps app:
/// Google Maps (or any map app) on Android, Apple Maps on iOS.
class MapsLauncher {
  /// Returns false when no app could open the location.
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

    // No maps app installed: fall back to Google Maps in the browser.
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
