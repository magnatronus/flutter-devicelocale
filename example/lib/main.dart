import 'dart:async';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

/// Demo getting a device locale
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List? _languages = [];
  String? _locale;
  String? _country;
  String? _language;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    List? languages = [];
    String? currentLocale;
    String? country;
    String? language;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      languages = await Devicelocale.preferredLanguages;
      print((languages != null)
          ? languages
          : "unable to get preferred languages");
    } on PlatformException {
      print("Error obtaining preferred languages");
    }
    try {
      currentLocale = await Devicelocale.currentLocale;
      country = await Devicelocale.currentCountry;
      language = await Devicelocale.currentLanguage;
      print((currentLocale != null)
          ? currentLocale
          : "Unable to get currentLocale");
    } on PlatformException {
      print("Error obtaining current locale");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _languages = languages;
      _locale = currentLocale;
      _country = country;
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text("Current locale: "),
            Text('$_locale'),
            Text("Current country: "),
            Text('$_country'),
            Text("Current language: "),
            Text('$_language'),
            Text("Preferred Languages: "),
            Text(_languages.toString()),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    listLanguages();
                  },
                  child: Text("Run Test")),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  await testAsLocale();
                  await testLanguagesAsLocales();
                },
                child: Text("Test currentAsLocale"),
              ),
            ),
          ],
        )),
      ),
    );
  }

  /// Show the use of the currentAsLocale Function
  Future<void> testAsLocale() async {
    Locale? l = await Devicelocale.currentAsLocale;
    if (l != null) {
      print(
          "CurrentAsLocale result: Language Code: ${l.languageCode} , Country Code: ${l.countryCode}");
    } else {
      print('Unable to determine currentAsLocale');
    }
  }

  /// Show the use of the preferredLanguagesAsLocale Function
  Future<void> testLanguagesAsLocales() async {
    List<Locale> languageLocales =
        await Devicelocale.preferredLanguagesAsLocales;
    print(languageLocales);
    print("Preferred languagesAsLocales:");
    languageLocales.forEach((l) {
      print(
          "- Language Code: ${l.languageCode} , Country Code: ${l.countryCode}");
    });
  }

  /// testing for issue-12
  Future<void> listLanguages() async {
    List? languages = await Devicelocale.preferredLanguages;
    String? locale = await Devicelocale.currentLocale;
    if (locale != null) {
      print('current locale: $locale');
    }
    if (languages != null) {
      print('preferred device languages:');
      languages.forEach((l) => print(' - $l'));
    }
  }
}
