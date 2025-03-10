import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/app_pages.dart';
import 'bindings/app_binding.dart';
import 'constants/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/notification_service.dart';
import 'controllers/theme_controller.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();

    final notificationService = NotificationService();
    await notificationService.init();

    Get.put(ThemeController());

    runApp(const MyApp());
  } catch (e, stackTrace) {
    debugPrint('Başlatma hatası: $e\n$stackTrace');
    runApp(const ErrorApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luvoria AI',
      theme: AppTheme.lightTheme,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: '/',
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
      defaultTransition: Transition.fade,
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'Uygulama başlatılırken bir hata oluştu.',
            style: GoogleFonts.poppins(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
