import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return android;
    }
    throw UnsupportedError(
      'Firebase is only configured for Android. Register the app for '
      '${kIsWeb ? 'web' : defaultTargetPlatform.name} in the Firebase console.',
    );
  }

  static const android = FirebaseOptions(
    apiKey: 'AIzaSyA9ndCn0kA5inVdwv6jJ-UPwgKuW6zzVY4',
    appId: '1:413894464094:android:4fbb4ef086385988075acf',
    messagingSenderId: '413894464094',
    projectId: 'tourist-guide-app-c2825',
    storageBucket: 'tourist-guide-app-c2825.firebasestorage.app',
  );
}
