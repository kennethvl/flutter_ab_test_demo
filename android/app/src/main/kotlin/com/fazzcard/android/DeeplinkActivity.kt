package com.fazzcard.android

import android.app.Activity
import android.content.Intent
import android.os.Bundle

class DeeplinkActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        BaseApplication.runBaseApplication(this) {
            dynamicLink.handleIntent(intent)
        }
        startActivity(Intent(this, MainActivity::class.java))

    }
}