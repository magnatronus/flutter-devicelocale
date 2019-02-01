import Flutter
import UIKit

public class SwiftDevicelocalePlugin: NSObject, FlutterPlugin {
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "uk.spiralarm.flutter/devicelocale", binaryMessenger: registrar.messenger())
    let instance = SwiftDevicelocalePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch(call.method){
      case "preferredLanguages": result(getpreferredLanguages())
      default: result(FlutterMethodNotImplemented)
    }
  }

  private func getpreferredLanguages() -> Array<String> {
    return Locale.preferredLanguages
  }


}
