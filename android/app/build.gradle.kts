plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // ⚠ Do NOT put id("com.google.gms.google-services") here
}

android {
    namespace = "com.smart.wallet"
    compileSdk = flutter.compileSdkVersion

    defaultConfig {
        applicationId = "com.smart.wallet"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BOM for Android
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    // Firebase services you use
    implementation("com.google.firebase:firebase-analytics")

}

// ✅ Apply Google Services plugin at the bottom
apply(plugin = "com.google.gms.google-services")
