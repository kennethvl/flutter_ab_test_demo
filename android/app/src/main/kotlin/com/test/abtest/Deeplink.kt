package com.test.abtest

import android.content.Context
import android.content.Intent
import android.net.Uri
import com.google.firebase.dynamiclinks.DynamicLink
import com.google.firebase.dynamiclinks.FirebaseDynamicLinks
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class Deeplink {

    companion object {


        const val GENERATE = "generate"
        const val LINK = "link"
        const val DOMAIN_URI_PREFIX = "prefix"
    }

    fun handleIntent(context: Context, intent: Intent) {
        instance.getDynamicLink(intent)
                .addOnSuccessListener {
                    it?.let {
                        val uri = it.link.toString()
                        val mainIntent = Intent(context, MainActivity::class.java)
                        mainIntent.putExtra("URI", uri)
                        context.startActivity(mainIntent)
                    }
                }
    }

    private val instance = FirebaseDynamicLinks.getInstance()
    val handleCall = MethodChannel.MethodCallHandler { call, result ->
        when (call.method) {
            GENERATE -> generate(call, result)
            else -> result.error("FAILED", "method ${call.method} not implemented", null)
        }
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