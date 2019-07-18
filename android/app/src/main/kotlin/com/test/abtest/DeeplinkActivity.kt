package com.test.abtest

import android.app.Activity
import android.os.Bundle

class DeeplinkActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Deeplink().handleIntent(this, intent)
    }
}