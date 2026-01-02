import 'package:get/get.dart';
import '../../views/web_browser/web_browser_view.dart';
import '../../viewmodels/web_browser_viewmodel.dart';

/// Centralized routing configuration
/// Uses lazy loading for ViewModels to improve performance
class AppRoutes {
  static const String webBrowser = '/web-browser';
  static const String initial = webBrowser;

  static final List<GetPage> pages = [
    GetPage(
      name: webBrowser,
      page: () => const WebBrowserView(),
      binding: BindingsBuilder(() {
        // Lazy load ViewModel only when route is accessed
        Get.lazyPut<WebBrowserViewModel>(() => WebBrowserViewModel());
      }),
      transition: Transition.fadeIn,
    ),
  ];
}
