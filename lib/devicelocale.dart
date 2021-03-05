/// Copyright (c) 2019-2021, Steve Rogers. All rights reserved. Use of this source code
/// is governed by an Apache License 2.0 that can be found in the LICENSE file.
import 'dart:async';
import 'dart:ui';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

/// A Simple plug-in that can be used to query a device( iOS or Android) to obtain a list of current set up locales and languages
class Devicelocale {
  static const MethodChannel _channel =
      const MethodChannel('uk.spiralarm.flutter/devicelocale');

  /// return a [Locale] based on the passed in String [info] or the [defaultLocale] and the platform
  static Locale? _getAsLocale(String? info, String? defaultLocale) {
    if (info == null) {
      return null;
    }
    final String token = (Platform.isIOS) ? "-" : "_";
    try {
      List localeList = info.split(token);
      if (localeList.length < 2) {
        if (defaultLocale != null) {
          List defaultList = defaultLocale.split(token);
          if (defaultList.length >= 2) {
            return Locale(defaultList[0], defaultList[1]);
          } else {
            return Locale(defaultList[0]);
          }
        }
      }
      return Locale(localeList[0], localeList[1]);
    } catch (e) {
      return null;
    }
  }

  /// Returns a [List] of locales from the device
  /// the first in the list should be the current one set on the device
  static Future<List?> get preferredLanguages async {
    final List? version = await _channel.invokeMethod('preferredLanguages');
    return version;
  }

  /// Return a [List] of [Locales] based on the list of preferred languages
  /// This is the same list returned by [preferredlanguages]  but as a [Locales] rather than [Strings]
  static Future<List<Locale>> get preferredLanguagesAsLocales async {
    final String? defaultLocale = await _channel.invokeMethod('currentLocale');
    final List? version = await _channel.invokeMethod('preferredLanguages');
    if (version == null) {
      return [];
    }
    return version
        .map((locale) {
          return _getAsLocale(locale, defaultLocale);
        })
        .toList()
        .cast<Locale>();
  }

  /// Returns a [String] of the currently set DEVICE locale made up of the language and the region
  /// (e.g. en-US or en_US)
  static Future<String?> get currentLocale async {
    final String? locale = await _channel.invokeMethod('currentLocale');
    return locale;
  }

  /// Returns a [Locale] of the currently set DEVICE locale made up of the language and the region
  static Future<Locale?> get currentAsLocale async {
    final String? locale = await _channel.invokeMethod('currentLocale');
    return _getAsLocale(locale, null);
  }
}
