/// Copyright (c) 2019-2020, Steve Rogers. All rights reserved. Use of this source code
/// is governed by an Apache License 2.0 that can be found in the LICENSE file.
import 'dart:async';
import 'dart:ui';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

/// A Simple plug-in that can be used to r a device( iOS or Android) to obtain a list of current set up locales and languages
class Devicelocale {
  static const MethodChannel _channel =
      const MethodChannel('uk.spiralarm.flutter/devicelocale');

  /// return a [Locale] based on the passed in String [info] and the platform
  static _getAsLocale(String info) {
    final String token = (Platform.isIOS) ? "-" : "_";
    try {
      List localeList = info.split(token);
      if (localeList.length == 2) {
        return Locale(localeList[0], localeList[1]);
      }
      return Locale(localeList[0]);
    } catch (e) {
      return null;
    }
  }

  /// Returns a [List] of locales from the device
  /// the first in the list should be the current one set on the device
  static Future<List> get preferredLanguages async {
    final List version = await _channel.invokeMethod('preferredLanguages');
    return version;
  }

  /// Return a [List] of [Locales] based on the list of preferred languages
  /// This is the same list returned by [preferredlanguages]  but as a [Locales] rather than [Strings]
  static Future<List> get preferredLanguagesAsLocales async {
    final List version = await _channel.invokeMethod('preferredLanguages');
    return version
        .map((locale) {
          return _getAsLocale(locale);
        })
        .toList()
        .cast<Locale>();
  }

  /// Returns a [String] of the currently set DEVICE locale made up of the language and the region
  /// (e.g. en-US or en_US)
  static Future<String> get currentLocale async {
    final String locale = await _channel.invokeMethod('currentLocale');
    return locale;
  }

  /// Returns a [Locale] of the currently set DEVICE locale made up of the language and the region
  static Future<Locale> get currentAsLocale async {
    final String locale = await _channel.invokeMethod('currentLocale');
    return _getAsLocale(locale);
  }
}
