/// Copyright (c) 2019-2020, Steve Rogers. All rights reserved. Use of this source code
/// is governed by an Apache License 2.0 that can be found in the LICENSE file.
import 'dart:async';
import 'package:flutter/services.dart';

/// A Simple plug-in that can be used to interogate a device( iOS or Android) to obtain a list of current set up locales and languages
class Devicelocale {
  static const MethodChannel _channel =
      const MethodChannel('uk.spiralarm.flutter/devicelocale');

  /// Returns a [List] of locales from the device
  /// the first in the list should be the current one set on the device
  /// for example iOS **['en-GB', 'es-GB'] or for Android **['en_GB, 'es_GB]**
  static Future<List> get preferredLanguages async {
    final List version = await _channel.invokeMethod('preferredLanguages');
    return version;
  }

  /// Returns a [String] of the currently set DEVICE locale made up of the language and the region
  /// (e.g. en-US or en_US)
  static Future<String> get currentLocale async {
    final String locale = await _channel.invokeMethod('currentLocale');
    return locale;
  }
}
