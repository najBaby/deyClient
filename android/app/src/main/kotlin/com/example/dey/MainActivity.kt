package com.example.dey

import io.flutter.embedding.android.FlutterActivity

import android.os.Build
import android.os.Bundle
import java.security.KeyManagementException
import java.security.NoSuchAlgorithmException
import com.google.android.gms.security.ProviderInstaller
import com.google.android.gms.common.GooglePlayServicesNotAvailableException
import com.google.android.gms.common.GooglePlayServicesRepairableException

class MainActivity: FlutterActivity() {
     override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (Build.VERSION.SDK_INT in 17..20) {
            try {
                ProviderInstaller.installIfNeeded(applicationContext)
            } catch (e: GooglePlayServicesRepairableException) {
                e.printStackTrace()
            } catch (e: GooglePlayServicesNotAvailableException) {
                e.printStackTrace()
            } catch (e: NoSuchAlgorithmException) {
                e.printStackTrace()
            } catch (e: KeyManagementException) {
                e.printStackTrace()
            }
        }
    }
}
