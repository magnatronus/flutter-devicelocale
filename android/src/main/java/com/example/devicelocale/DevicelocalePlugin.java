package com.example.devicelocale;

import androidx.annotation.ChecksSdkIntAtLeast;
import androidx.annotation.NonNull;

import androidx.annotation.RequiresApi;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import androidx.core.os.LocaleListCompat;

import android.app.LocaleManager;
import android.content.Context;
import android.os.Build;
import android.os.Handler;
import android.os.LocaleList;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * DevicelocalePlugin
 */
public class DevicelocalePlugin implements MethodCallHandler, FlutterPlugin {

  private MethodChannel channel;
  private Context applicationContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    applicationContext = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "uk.spiralarm.flutter/devicelocale");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
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
      case "setLanguagePerApp":
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
          result.success(setLanguagePerAppSetting(call));
        } else {
          result.success(false);
        }
        break;
      case "isLanguagePerAppSettingSupported":
        result.success(isLanguagePerAppSettingSupported());
        break;
      default:
        result.notImplemented();
    }
  }

  private String getCurrentLocale() {
    return getLocaleTag(Locale.getDefault());
  }


  private List<String> getPreferredLanguages() {
    List<String> result = new ArrayList<>();

    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.N) {
      LocaleListCompat list = LocaleListCompat.getAdjustedDefault();
      for (int i = 0; i < list.size(); i++) {
        result.add(getLocaleTag(list.get(i)));
      }
    } else {
      result.add(getCurrentLocale());
    }

    return result;
  }

  private String getLocaleTag(Locale locale) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      return locale.toLanguageTag();
    } else {
      return locale.toString();
    }
  }

  @RequiresApi(api = Build.VERSION_CODES.TIRAMISU)
  @ChecksSdkIntAtLeast(api = Build.VERSION_CODES.TIRAMISU)
  private boolean setLanguagePerAppSetting(MethodCall methodCall) {
  	final String locale = methodCall.argument("locale");
    final Handler mainHandler = new Handler(applicationContext.getMainLooper());
    final Runnable myRunnable = new Runnable() {
      public void run() {
        final LocaleList appLocale = LocaleList.forLanguageTags(locale);
        final LocaleManager service = applicationContext.getSystemService(LocaleManager.class);
        service.setApplicationLocales(appLocale);
      }
    };
    mainHandler.post(myRunnable);
  	return true;
  }

  @ChecksSdkIntAtLeast(api = Build.VERSION_CODES.TIRAMISU)
  private boolean isLanguagePerAppSettingSupported() {
    return Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU;
  }
}
