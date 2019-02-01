# devicelocale

Gets the device locale data, independent of the app locale settings.

# Usage
```
import 'package:devicelocale/devicelocale.dart';
```

then

```
List languages = await Devicelocale.preferredLanguages;
```

this should return a list of the preferred/current language locales setup on the device, with the current one being the first in the list.



## Getting Started

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
