import 'dart:async';
import 'dart:js_interop';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web show window;

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
    final List? languages =
        web.window.navigator.languages.toDart.map((e) => e.toDart).toList();
    return Future.value(languages);
  }

  Future<String?> getCurrentLocale() {
    final String? locale = web.window.navigator.language;
    return Future.value(locale);
  }
}
