import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:solution/views/widgets/selection_action_bubble.dart';
import '../../viewmodels/web_browser_viewmodel.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

/// Main screen with real webpage browsing and text selection AI flow
class WebBrowserView extends StatelessWidget {
  const WebBrowserView({super.key});

  @override
  Widget build(BuildContext context) {
    final WebBrowserViewModel vm = Get.find<WebBrowserViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia'),
        backgroundColor: AppColors.cardBackground,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
                url: WebUri('https://en.wikipedia.org/wiki/Grammar')),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              // Fixed: Correct setting name in flutter_inappwebview ^6.0.0+
              useHybridComposition: true,
            ),
            onLoadStop: (controller, url) async {
              await controller.evaluateJavascript(source: '''
                document.addEventListener('selectionchange', () => {
                  const selection = window.getSelection();
                  const text = selection.toString().trim();
                  if (text) {
                    const range = selection.getRangeAt(0);
                    const rect = range.getBoundingClientRect();
                    const pos = { x: rect.left + rect.width / 2, y: rect.top + window.scrollY };
                    window.flutter_inappwebview.callHandler('onSelection', text, pos.x, pos.y);
                  } else {
                    window.flutter_inappwebview.callHandler('onClear');
                  }
                });
              ''');
            },
            onWebViewCreated: (controller) {
              controller.addJavaScriptHandler(
                  handlerName: 'onSelection',
                  callback: (args) {
                    vm.onTextSelected(args[0],
                        Offset(args[1].toDouble(), args[2].toDouble()));
                  });
              controller.addJavaScriptHandler(
                  handlerName: 'onClear', callback: (_) => vm.clearSelection());
            },
            onScrollChanged: (_, __, ___) => vm.clearSelection(),
            onLoadError: (_, __, ___, ____) {
              Get.snackbar('Error', AppStrings.pageError);
            },
          ),

          // Dynamic bubble overlay – now correctly imported
          Obx(() => vm.showBubble.value
              ? SelectionActionBubble(position: vm.bubblePosition.value!)
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
