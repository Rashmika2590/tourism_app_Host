// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDuF1Q-oA34IIpK_Qfy5r6iXpRpzVOPZ3U',
    appId: '1:182588043885:web:889ec184b017561d088564',
    messagingSenderId: '182588043885',
    projectId: 'tourism-app-host',
    authDomain: 'tourism-app-host.firebaseapp.com',
    storageBucket: 'tourism-app-host.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB28XoL5JVVkGCGYIy7B7Sl4oTecuoerIk',
    appId: '1:182588043885:android:8c6503a5622966eb088564',
    messagingSenderId: '182588043885',
    projectId: 'tourism-app-host',
    storageBucket: 'tourism-app-host.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDV-Jvo5zy6-irPTQJ7QG2gtJdXlDJtaQ4',
    appId: '1:182588043885:ios:56132527972e269a088564',
    messagingSenderId: '182588043885',
    projectId: 'tourism-app-host',
    storageBucket: 'tourism-app-host.firebasestorage.app',
    iosBundleId: 'com.example.tourismHost',
  );
}
