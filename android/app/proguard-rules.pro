# Flutter Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Local Auth & Biometric
-keep class androidx.biometric.** { *; }

# Flutter Secure Storage & Crypto
-keep class androidx.security.crypto.** { *; }

# SQFlite & Database
-keep class com.tekartik.sqflite.** { *; }

# Display Mode
-keep class com.github.sbugert.displaymode.** { *; }

# Suppress Warnings
-dontwarn io.flutter.**
-dontwarn androidx.**
