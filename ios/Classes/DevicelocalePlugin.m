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
  } else {
    result(FlutterMethodNotImplemented);
  }
}
@end
