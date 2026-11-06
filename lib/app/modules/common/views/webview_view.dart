import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../controllers/common_controller.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final CommonController controller = Get.isRegistered<CommonController>()
      ? Get.find<CommonController>()
      : Get.put(CommonController());

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    String url = 'https://flutter.dev';
    String? title;

    if (args is Map) {
      if (args['url'] != null) url = args['url'].toString();
      if (args['title'] != null) title = args['title'].toString();
    } else if (args is String) {
      url = args;
    }

    controller.initWebview(url, title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.pageTitle.value.isNotEmpty
            ? controller.pageTitle.value
            : AppStrings.webview.tr,
      ),
      body: Obx(
        () => Stack(
          children: [
            if (controller.webViewController != null)
              WebViewWidget(controller: controller.webViewController!),
            if (controller.isWebLoading.value)
              LinearProgressIndicator(
                value: controller.webProgress.value / 100.0,
                backgroundColor: Colors.transparent,
              ),
          ],
        ),
      ),
    );
  }
}
