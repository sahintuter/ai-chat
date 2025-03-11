# Flutter proguard kuralları
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Play Core için gerekli kurallar
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

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

# Model sınıfları - sadece kullanılan sınıfları tut
-keep class com.luvoria.chat.models.** { *; }

# Genel Android kuralları
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keepattributes Signature
-keep public class * extends java.lang.Exception

# Reflection kullanılan sınıfları koru
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Enum'ları koru
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Serileştirme için
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# R8 full mode
-allowaccessmodification
-repackageclasses
-keepattributes Exceptions

# Debugging için kaynak dosya adlarını koru
-renamesourcefileattribute SourceFile

# Native metodları koru
-keepclasseswithmembernames class * {
    native <methods>;
}

# Uygulama için özel kurallar
-keep class com.luvoria.chat.** { *; }
-keepclassmembers class com.luvoria.chat.** { *; } 