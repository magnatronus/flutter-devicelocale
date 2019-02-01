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


## iOS
This is a Swift plug-in and seems to suffer from the issues mentioned [here](https://github.com/flutter/flutter/issues/16049).

But if you follow the advice in this [comment](https://github.com/flutter/flutter/issues/16049#issuecomment-438589363) , but set the Swift Version to 4.0 not 3.2.  it should work fine.


## Getting Started

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
