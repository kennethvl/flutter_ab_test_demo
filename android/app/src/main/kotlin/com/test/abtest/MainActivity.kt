package com.test.abtest

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private val AB_TEST_CHANNEL = "ab-test"
    private val DYNAMIC_LINK_CHANNEL = "dynamic-link"
    private val remoteConfig = RemoteConfig()
    private val dynamicLink = Deeplink()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        dynamicLink.handleIntent(this, intent)

        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, AB_TEST_CHANNEL).setMethodCallHandler(remoteConfig.handleCall)
        MethodChannel(flutterView, DYNAMIC_LINK_CHANNEL).setMethodCallHandler(dynamicLink.handleCall)
    }
}
