package com.fazzcard.android

import android.app.Activity
import io.flutter.app.FlutterApplication

class BaseApplication : FlutterApplication() {
    companion object {
        fun runBaseApplication(activity: Activity, func: BaseApplication.() -> Unit) {
            if (activity.application is BaseApplication) {
                (activity.application as BaseApplication).func()
            }
        }
    }

    val dynamicLink = Deeplink()

    override fun onCreate() {
        super.onCreate()
        dynamicLink.initialize()
    }

}