# devicelocale

Gets the device locale data, independent of the app locale settings.

# Usage
```dart
import 'package:devicelocale/devicelocale.dart';
```

then

```dart
List languages = await Devicelocale.preferredLanguages;
String locale = await Devicelocale.currentLocale;
```

this should return a list of the preferred/current language locales setup on the device, with the current one being the first in the list or just the currently set device locale.


## iOS
When first created this was a Swift based plugin, but due to [these issues](https://github.com/flutter/flutter/issues/16049) the Swift code has been removed and it now uses a simple Objective C call.


## Updates

- Sep 2019 0.2.0 Updated Android following feedback from https://github.com/huzhirento . Fallback to the currentLocale when attempting to get a list of locales fro Android 7 and below as the getLocales() call is a feature of API 24 and failed for Android 7 and below.


## Getting Started

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
