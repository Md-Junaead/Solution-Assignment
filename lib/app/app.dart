import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../core/constants/app_colors.dart';

/// Root widget of the application
/// Configures GetMaterialApp with theme, routing, and global navigator key
/// navigatorKey prevents platform view assertion errors on Android
class App extends StatelessWidget {
  const App({super.key});

  // Global navigator key for stable navigation with platform views (WebView)
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Grok Writing Assistant',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,

      // Light & dark theme using Grok blue as seed
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.grokBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.grokBlue,
          brightness: Brightness.dark,
        ),
      ),

      // Routing setup
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.pages,

      // Fallback route
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(body: Center(child: Text('Page Not Found'))),
      ),
    );
  }
}
