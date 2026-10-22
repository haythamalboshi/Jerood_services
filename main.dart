import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants.dart';
import 'theme/cupertino_theme.dart';
import 'services/storage_service.dart';
import 'services/notification_service.dart';
import 'services/analytics_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize background & local services safely
  final storage = await StorageService.init();
  await NotificationService().init();
  await AnalyticsService().init();

  runApp(JeroodApp(storage: storage));
}

class JeroodApp extends StatelessWidget {
  final StorageService storage;

  const JeroodApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Apple Cupertino Themes (Light and Dark)
      theme: JeroodTheme.lightTheme,

      // 100% Arabic Native RTL Localization
      locale: const Locale('ar', 'SY'),
      supportedLocales: const [
        Locale('ar', 'SY'),
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      home: Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(storage: storage),
      ),
    );
  }
}
