import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:devicelocale/devicelocale.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List? _languages = [];
  String? _currentLocale;
  String? _defaultLocale;
  bool _isSupported = false;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text("Default locale: "),
              Text('$_defaultLocale'),
              ElevatedButton(
                onPressed: _getDefaultLocale,
                child: Text("Refresh"),
              ),
              SizedBox(height: 8),
              Text("Reported Current locale: "),
              Text('$_currentLocale'),
              ElevatedButton(
                onPressed: _getCurrentLocale,
                child: Text("Refresh"),
              ),
              SizedBox(height: 8),
              Container(
                color: Colors.blue,
                height: 1,
              ),
              SizedBox(height: 8),
              Text("Preferred Languages: "),
              Text(_languages.toString()),
              ElevatedButton(
                onPressed: _getPreferredLanguages,
                child: Text("Refresh"),
              ),
              SizedBox(height: 8),
              Container(
                color: Colors.blue,
                height: 1,
              ),
              if (_isSupported) ...[
                Text("Save languages: "),
                ElevatedButton(
                  onPressed: () => _saveLanguage(Locale("fr", "FR")),
                  child: Text("Save fr-FR"),
                ),
                SizedBox(height: 8),
                Container(
                  color: Colors.blue,
                  height: 1,
                ),
                ElevatedButton(
                  onPressed: () => _saveLanguage(Locale("en", "CA")),
                  child: Text("Save en-CA"),
                ),
                SizedBox(height: 8),
                Container(
                  color: Colors.blue,
                  height: 1,
                ),
              ] else ...[
                Text('Set language per app is not available on OS level'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initPlatformState() async {
    _getCurrentLocale();
    _getDefaultLocale();
    _getPreferredLanguages();
    _checkForSupport();
  }

  Future<void> _getDefaultLocale() async {
    try {
      final defaultLocale = await Devicelocale.defaultLocale;
      print((defaultLocale != null)
          ? defaultLocale
          : "Unable to get defaultLocale");
      setState(() => _defaultLocale = defaultLocale);
    } on PlatformException {
      print("Error obtaining default locale");
    }
  }

  Future<void> _getCurrentLocale() async {
    try {
      final currentLocale = await Devicelocale.currentLocale;
      print((currentLocale != null)
          ? currentLocale
          : "Unable to get currentLocale");
      setState(() => _currentLocale = currentLocale);
    } on PlatformException {
      print("Error obtaining current locale");
    }
  }

  Future<void> _getPreferredLanguages() async {
    try {
      final languages = await Devicelocale.preferredLanguages;
      print((languages != null)
          ? languages
          : "unable to get preferred languages");
      setState(() => _languages = languages);
    } on PlatformException {
      print("Error obtaining preferred languages");
    }
  }

  Future<void> _checkForSupport() async {
    final isSupported = await Devicelocale.isLanguagePerAppSettingSupported;
    setState(() => _isSupported = isSupported);
  }

  Future<void> _saveLanguage(Locale locale) async {
    await Devicelocale.setLanguagePerApp(locale);
  }
}
