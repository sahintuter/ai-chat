# ai_chat_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


```
 Future<String> getId() async {
    String deviceId = "";

    if (Platform.isIOS) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      // identifierForVendor null veya boş ise alternatif ID oluştur
      if (iosInfo.identifierForVendor != null &&
          iosInfo.identifierForVendor!.isNotEmpty) {
        deviceId = iosInfo.identifierForVendor!;
      } else {
        // Keychain'den kayıtlı ID'yi al veya yeni oluştur
        const storage = FlutterSecureStorage();
        String? storedId = await storage.read(key: 'device_fallback_id');

        if (storedId != null && storedId.isNotEmpty) {
          deviceId = storedId;
        } else {
          // Cihaza özgü sabit bir ID oluştur
          String fallbackId =
              '${iosInfo.model}-${iosInfo.systemVersion}-${DateTime.now().millisecondsSinceEpoch}';
          await storage.write(key: 'device_fallback_id', value: fallbackId);
          deviceId = fallbackId;
        }
      }
    } else {
      const androidIdPlugin = AndroidId();
      deviceId = await androidIdPlugin.getId() ?? '';
      return deviceId;
    }

    return deviceId;
  }
```
