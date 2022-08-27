#import "DevicelocalePlugin.h"

@implementation DevicelocalePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"uk.spiralarm.flutter/devicelocale"
            binaryMessenger:[registrar messenger]];
  DevicelocalePlugin* instance = [[DevicelocalePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

  if ([@"preferredLanguages" isEqualToString:call.method]) {
    result([NSLocale preferredLanguages]);
  } else if([@"currentLocale" isEqualToString:call.method]){
    NSString *locale = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    NSString *language = [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];
    if(locale == nil) {
      NSString *formattedStr = [NSString stringWithFormat:@"%@",language];
      result(formattedStr);
    } else {
    NSString *formattedStr = [NSString stringWithFormat:@"%@-%@",language, locale];
    result(formattedStr);
    };
  } else {
    result(FlutterMethodNotImplemented);
  }
}
@end
