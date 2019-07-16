package com.example.flutter_ab_test_demo

import com.google.firebase.remoteconfig.FirebaseRemoteConfig
import com.google.firebase.remoteconfig.FirebaseRemoteConfigSettings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class RemoteConfig() {

    companion object {
        const val GET_STRING = "fetchFirstText"
        const val KEY = "key"
    }

    val handleCall = MethodChannel.MethodCallHandler { call, result ->
        when (call.method) {
            GET_STRING -> handleGetString(call, result)
            else -> result.error("FAILED", "method not implemented", null)
        }

    }

    private fun handleGetString(call: MethodCall, result: MethodChannel.Result) {
        call.argument<String>(KEY)?.let { key ->
            instance.fetchAndActivate().addOnCompleteListener {
                if (it.isSuccessful) {
                    val data = instance.getString(key)
                    result.success(data)
                } else {
                    result.error("FAILED", "task fetching is not successfull", null)
                }
            }.addOnCanceledListener {
                result.error("FAILED", "failed to fetch firebase", null)
            }
        } ?: result.error("FAILED", "a key must be provided", null)
    }

    private val instance = FirebaseRemoteConfig.getInstance()

    fun initiateDefault() {
        instance.setDefaults(R.xml.remote_config_defautls)
        val configSettings = FirebaseRemoteConfigSettings.Builder()
                .setDeveloperModeEnabled(true)
                .setMinimumFetchIntervalInSeconds(0)
                .build()
        instance.setConfigSettings(configSettings)
    }

    init {
        initiateDefault()
    }
}