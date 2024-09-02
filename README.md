# devicelocale

Gets the device locale data, independent of the app locale settings. 


## Usage

```dart
import 'package:devicelocale/devicelocale.dart';
```

then

```dart
List languages = await Devicelocale.preferredLanguages;
String locale = await Devicelocale.currentLocale;
```

this should return a list of the preferred/current language locales setup on the device, with the current one being the first in the list or just the currently set device locale.

### Android specific implementation (no-op on other platforms if supported)
Added per-app language preferences for Android (https://developer.android.com/about/versions/13/features/app-languages#kotlin)
You can check if your current device is supported `isLanguagePerAppSettingSupported`
And after checking if your device is supported you can set the per-app language preference with `setLanguagePerApp(Locale)` this will return true if success

### Note for Linux

Since GNU/Linux and POSIX doesn't provide a standard API for getting the preferred languages, `Devicelocale.preferredLanguages` always returns the current locale.

## Updates

### Sept 2023
merged pull request for compatibility with AGP 8

### Feb 2023
Added  2 new functions for this [iOS issue](https://github.com/magnatronus/flutter-devicelocale/issues/38)

- defaultLocale
 - defaultAsLocale
 

### July 2022
Added support for per-app language preferences on Android (https://developer.android.com/about/versions/13/features/app-languages#kotlin)
You can now set the per-app language if you have an in app language picker.
Updated the demo app

### May 2022
Merged pull requests

### Oct 2021
Updated the code and APIs used by Flutter for an Android plugin - this was the source of the Deprecated API warning in the Android build.

### July 2021
Add beta support for Linux

### March 2021

Added test support for web

Updated for null safety

### Jul 2020 Locale update v0.3.1

This is an update from a received request, where prior to 0.3.1  the 2 methods:

- **preferredLanguages**
- **currentLocale**

returned string values.

There are now 2 equivilent methods

- **preferredLanguagesAsLocales**
- **currentAsLocale**

that now also return a **Locale** object rather than a string.

### releases

- March 2021 1.0.0 Updated to null safety

- July 2020 0.3.0 Updated Android to support Android Embedding V2

- Apr 2020 0.2.3 Updated Android code from contributions from @ened

- Mar 2020 0.2.2 Updated iOS so that if detected locale is null then it is not included in return value

- Sep 2019 0.2.0 Updated Android following feedback from https://github.com/huzhirento . Fallback to the currentLocale when attempting to get a list of locales fro Android 7 and below as the getLocales() call is a feature of API 24 and failed for Android 7 and below.

## Getting Started

For help getting started with Flutter, view our
[online documentation](https://flutter.io/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
