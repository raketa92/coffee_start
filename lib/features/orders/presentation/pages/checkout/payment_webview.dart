import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentUrl;
  const PaymentWebView({super.key, required this.paymentUrl});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initializeWebViewController();
  }

  void _initializeWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('Loading progress: $progress%');
        },
        onPageStarted: (String url) {
          debugPrint('Page started loading: $url');
        },
        onPageFinished: (String url) {
          debugPrint('Page finished loading: $url');
        },
        onNavigationRequest: (NavigationRequest request) {
          // Redirect handling
          if (request.url.contains('/order-complete')) {
            Navigator.of(context).pop(true); // Return success status
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onHttpError: (HttpResponseError error) {
          debugPrint(
              'HTTP error: ${error.response?.statusCode} ${error.response?.uri}');
        },
      ))
      ..loadRequest(Uri.parse(widget.paymentUrl));

    // Platform-specific settings (optional)
    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop(false); // Return failure status
          },
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
