plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.dompet_harian"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.example.dompet_harian"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        // Pastikan versionCode selalu naik agar update APK tidak gagal downgrade
        versionCode = if (flutter.versionCode < 17) 17 else flutter.versionCode
        versionName = flutter.versionName

        // Optimasi ABI ponsel fisik: hanya sertakan arsitektur ARM nyata (arm64-v8a & armeabi-v7a)
        // Menghapus x86/x86_64 emulator yang memakan 20-25 MB tidak terpakai di HP
        ndk {
            abiFilters.addAll(listOf("arm64-v8a", "armeabi-v7a"))
        }
    }

    buildTypes {
        release {
            // Aktifkan R8 code minification & resource shrinking untuk mengompres ukuran APK
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )

            // Signing with the debug keys so direct install works smoothly
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
