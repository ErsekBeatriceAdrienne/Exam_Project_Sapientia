package com.learning.learn_dsa

import android.os.Build
import android.view.Surface
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onResume() {
        super.onResume()
        // Android 12 és újabb verziók támogatása
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            try {
                // Ellenőrizzük a Flutter renderer elérhetőségét
                flutterEngine?.renderer?.javaClass?.getMethod(
                    "setFrameRate",
                    Float::class.java,
                    Int::class.java
                )?.invoke(
                    flutterEngine?.renderer,
                    120.0f,
                    Surface.FRAME_RATE_COMPATIBILITY_FIXED_SOURCE
                )
            } catch (e: Exception) {
                // Nem támogatott API esetén logoljuk a hibát
                e.printStackTrace()
            }
        }
    }
}
