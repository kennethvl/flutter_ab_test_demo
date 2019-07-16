package com.example.flutter_ab_test_demo

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.test.abtest/remote_config"
    private val remoteConfig = RemoteConfig()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        remoteConfig.initiateDefault()

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler(remoteConfig.handleCall)
    }
}
