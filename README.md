# devicelocale

Gets the device locale data, independent of the app locale settings.

# Usage
```
import 'package:devicelocale/devicelocale.dart';
```

then

```
List languages = await Devicelocale.preferredLanguages;
String locale = await Devicelocale.currentLocale;
```

this should return a list of the preferred/current language locales setup on the device, with the current one being the first in the list or just the currently set device locale.


## iOS
When first created this was a Swift based plugin, but due to [these issues](https://github.com/flutter/flutter/issues/16049) the Swift code has been removed and it now uses a simple Objective C call.


## Getting Started

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
