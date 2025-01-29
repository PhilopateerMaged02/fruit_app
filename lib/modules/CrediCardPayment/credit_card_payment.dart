import 'package:flutter/material.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditCardPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(ApiContest.visaUrl)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(ApiContest.visaUrl));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Pay with Credit Card'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
