# Flutter proguard kuralları
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase için kurallar (eğer kullanılıyorsa)
-keep class com.google.firebase.** { *; }

# SharedPreferences kullanan kodlar için
-keep class androidx.preference.** { *; }

# Kotlin
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }

# Retrofit ve API istekleri için (eğer kullanılıyorsa)
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }

# OkHttp için (eğer kullanılıyorsa)
-keepattributes Signature
-keepattributes *Annotation*
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**

# Gson için (eğer kullanılıyorsa)
-keep class com.google.gson.** { *; }
-keepattributes Signature
-keepattributes *Annotation*

# Model sınıfları
-keep class com.luvoria.chat.models.** { *; }

# Genel Android kuralları
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
-keep class androidx.** { *; } 