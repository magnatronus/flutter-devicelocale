import 'dart:async';

import 'package:flutter/services.dart';

class Devicelocale {
  static const MethodChannel _channel = const MethodChannel('uk.spiralarm.flutter/devicelocale');

  static Future<List> get preferredLanguages async {
    final List version = await _channel.invokeMethod('preferredLanguages');
    return version;
  }
}
