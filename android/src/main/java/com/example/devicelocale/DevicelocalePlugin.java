package com.example.devicelocale;

import androidx.annotation.NonNull;
import androidx.core.os.LocaleListCompat;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import android.content.Context;
import android.content.ContextWrapper;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * DevicelocalePlugin
 */
public class DevicelocalePlugin implements MethodCallHandler, FlutterPlugin {

  private Context applicationContext;
  private MethodChannel methodChannel;

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final DevicelocalePlugin instance = new DevicelocalePlugin();
    instance.onAttachedToEngine(registrar.context(), registrar.messenger());
  }

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    applicationContext = null;
    methodChannel.setMethodCallHandler(null);
    methodChannel = null;
  }  

  private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
    this.applicationContext = applicationContext;
    methodChannel = new MethodChannel(messenger, "uk.spiralarm.flutter/devicelocale");
    methodChannel.setMethodCallHandler(this);
  }


  @Override
  public void onMethodCall(MethodCall call, @NonNull Result result) {
    String method = call.method;
    switch (method) {
      case "preferredLanguages":
        result.success(getPreferredLanguages());
        break;
      case "currentLocale":
        result.success(getCurrentLocale());
        break;
      default:
        result.notImplemented();
    }
  }

  private String getCurrentLocale() {
    return Locale.getDefault().toString();
  }

  private List<String> getPreferredLanguages() {
    List<String> result = new ArrayList<String>();

    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
      LocaleListCompat list = LocaleListCompat.getAdjustedDefault();
      for (int i = 0; i < list.size(); i++) {
        result.add(list.get(i).toString());
      }
    } else {
      result.add(getCurrentLocale());
    }

    return result;
  }
}
