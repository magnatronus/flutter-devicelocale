#import "DevicelocalePlugin.h"
#import <devicelocale/devicelocale-Swift.h>

@implementation DevicelocalePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDevicelocalePlugin registerWithRegistrar:registrar];
}
@end
