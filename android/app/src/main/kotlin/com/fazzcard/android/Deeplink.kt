package com.fazzcard.android

import android.content.Intent
import android.net.Uri
import com.google.firebase.dynamiclinks.DynamicLink
import com.google.firebase.dynamiclinks.FirebaseDynamicLinks
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class Deeplink {

    companion object {
        const val GENERATE = "generate"
        const val INTENT = "intent"
        const val LINK = "link"
        const val DOMAIN_URI_PREFIX = "prefix"
    }

    fun handleIntent(intent: Intent) {
        instance.getDynamicLink(intent)
                .addOnSuccessListener {
                    it?.let {
                        uri = it.link.toString()
                    }
                }
    }

    lateinit var instance: FirebaseDynamicLinks
    fun initialize() {
        instance = FirebaseDynamicLinks.getInstance()
    }

    private var uri = ""
    val handleCall = MethodChannel.MethodCallHandler { call, result ->
        when (call.method) {
            GENERATE -> generate(call, result)
            INTENT -> getIntent(result)
            else -> result.error("FAILED", "method ${call.method} not implemented", null)
        }
    }

    private fun getIntent(result: MethodChannel.Result) {
        result.success(uri)
    }

    private fun generate(call: MethodCall, result: MethodChannel.Result) {
        call.argument<String>(LINK)?.let { link ->
            call.argument<String>(DOMAIN_URI_PREFIX)?.let { prefix ->
                val dynamicLink = instance.createDynamicLink()
                        .setLink(Uri.parse(link))
                        .setDomainUriPrefix(prefix)
                        .setAndroidParameters(DynamicLink.AndroidParameters.Builder().build())
                        .setIosParameters(DynamicLink.IosParameters.Builder("com.example.ios").build())
                        .buildDynamicLink()
                result.success(dynamicLink.uri.toString())
            } ?: result.error("FAILED", "prefix not provided", null)
        } ?: result.error("FAILED", "link not provided", null)
    }
}