import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';

/// A Simple plug-in that can be used to query a device( iOS or Android) to obtain a list of current set up locales and languages
/// Copyright (c) 2019-2024, Steve Rogers. All rights reserved. Use of this source code
/// is governed by an Apache License 2.0 that can be found in the LICENSE file.
class Devicelocale {
  static const MethodChannel _channel =
      const MethodChannel('uk.spiralarm.flutter/devicelocale');

  /// return a [Locale] based on the passed in String [info] or the [defaultLocale] and the platform
  static Locale? _getAsLocale(String? info, String? defaultLocale) {
    if (info == null) {
      return null;
    }

    final String token = info.contains('-') ? '-' : '_';
    try {
      List localeList = info.split(token);
      if (localeList.length < 2) {
        if (defaultLocale != null) {
          List defaultList = defaultLocale.contains('-')
              ? defaultLocale.split('-')
              : defaultLocale.split('_');
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
  ///
  /// On Linux, returns the current locale.
  static Future<List?> get preferredLanguages async {
    final List? version = await _channel.invokeMethod('preferredLanguages');
    return version;
  }

  /// Return a [List] of [Locales] based on the list of preferred languages
  /// This is the same list returned by [preferredlanguages]  but as a [Locales] rather than [Strings]
  ///
  /// On Linux, returns the current locale.
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

  /// Returns a [String] of the DEFAULT device locale made up of the language and the region
  /// (e.g. en-US or en_US).
  static Future<String?> get defaultLocale async {
    final List? locales = await preferredLanguages;
    if (locales == null || locales.isEmpty) {
      return await currentLocale;
    }
    return locales[0];
  }

  /// Returns the DEFAULT [Locale] of the devices made up of the language and the region
  static Future<Locale?> get defaultAsLocale async {
    final String? locale = await defaultLocale;
    return _getAsLocale(locale, null);
  }

  /// Returns a [String] of the currently set DEVICE locale made up of the language and the region
  /// (e.g. en-US or en_US)
  static Future<String?> get currentLocale async {
    final String? locale = await _channel.invokeMethod('currentLocale');
    return locale;
  }

  /// Returns a [Locale] of the currently set DEVICE locale made up of the language and the region
  static Future<Locale?> get currentAsLocale async {
    final String? locale = await currentLocale;
    return _getAsLocale(locale, null);
  }

  /// Returns a [bool] so you know if language per app setting is available.
  static Future<bool> get isLanguagePerAppSettingSupported async {
    if (!Platform.isAndroid) return false;
    final bool? isSupported =
        await _channel.invokeMethod('isLanguagePerAppSettingSupported');
    return isSupported ?? false;
  }

  /// Returns a [bool] so you know if language per app setting is available.
  static Future<bool> setLanguagePerApp(Locale locale) async {
    final isSupported = await isLanguagePerAppSettingSupported;
    if (!isSupported) return false;
    final data = {
      "locale": locale.toLanguageTag(),
    };
    final bool? result = await _channel.invokeMethod('setLanguagePerApp', data);
    return result ?? false;
  }
}
