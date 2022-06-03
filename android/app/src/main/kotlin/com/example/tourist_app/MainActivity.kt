package com.example.tourist_app

import androidx.annotation.NonNull
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setLocale("ru_RU")
    MapKitFactory.setApiKey("0fa596f8-2e02-4d03-bf95-941340a1c1ef")
    GeneratedPluginRegistrant.registerWith(flutterEngine)
  }
}
