import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the Devicelocale plugin.
class DevicelocaleWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      "uk.spiralarm.flutter/devicelocale",
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = DevicelocaleWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'currentLocale':
        return getCurrentLocale();
      case 'preferredLanguages':
        return getPreferredLanguages();
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'devicelocale for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  Future<List?> getPreferredLanguages() {
    final List? languages = html.window.navigator.languages;
    return Future.value(languages);
  }

  Future<String?> getCurrentLocale() {
    final String? locale = html.window.navigator.language;
    return Future.value(locale);
  }
}
