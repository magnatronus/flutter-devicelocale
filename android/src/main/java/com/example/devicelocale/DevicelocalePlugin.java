package com.example.devicelocale;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import android.content.res.Resources;
import android.os.LocaleList;
import 	java.util.*;

/** DevicelocalePlugin */
public class DevicelocalePlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "uk.spiralarm.flutter/devicelocale");
    channel.setMethodCallHandler(new DevicelocalePlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    String method = call.method;
    switch(method){
      case "preferredLanguages": result.success(getPreferredLanguages()); break;
      case "currentLocale": result.success(getCurrentLocale()); break;
      default: result.notImplemented();
    }
  }

  private String getCurrentLocale() {
    String locale = Locale.getDefault().toString();
    return locale; 
  }

  private List<String> getPreferredLanguages() {
    List<String> result = new ArrayList<String>();
    try {
      LocaleList list = Resources.getSystem().getConfiguration().getLocales().getAdjustedDefault();
      for(int i=0; i<list.size(); i++){
        result.add(list.get(i).toString());
      }
    }
    catch (Throwable t) {
      result.add(getCurrentLocale());
    }
    return result;
  }
}
