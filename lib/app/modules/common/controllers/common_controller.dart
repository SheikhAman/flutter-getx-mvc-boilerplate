import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/network/network_info.dart';
import '../../../core/routes/app_routes.dart';

class CommonController extends GetxController {
  final NetworkInfo networkInfo = NetworkInfo.to;

  // Webview
  WebViewController? webViewController;
  final RxInt webProgress = 0.obs;
  final RxBool isWebLoading = true.obs;
  final RxString pageTitle = 'Web Browser'.obs;

  void initWebview(String url, String? title) {
    if (title != null) pageTitle.value = title;

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            webProgress.value = progress;
          },
          onPageStarted: (String url) {
            isWebLoading.value = true;
          },
          onPageFinished: (String url) {
            isWebLoading.value = false;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<void> retryConnection() async {
    final connected = await networkInfo.checkConnection();
    if (connected) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }
}

