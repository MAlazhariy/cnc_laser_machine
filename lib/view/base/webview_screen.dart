import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.url,
    this.title,
  });

  final String url;
  final String? title;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  // double _webProgress = 0;

  final controller = WebViewController();

  // bool get _loading => _webProgress != 1;

  // void _updateProgress(int progress) {
  //   setState(() {
  //     _webProgress = progress / 100;
  //   });
  // }

  @override
  void initState() {
    super.initState();

    // init webView controller
    controller
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            log('-----error: ${error.errorCode} | ${error.description}');
          },
          onPageFinished: (url) {
            debugPrint('page finished: $url');
          },
          onPageStarted: (url) {
            // todo: updateConnectionStatus(_connectionStatus);
            log('page started: $url');
          },
          // onProgress: (progress) {
          //   _updateProgress(progress);
          // },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.title != null ? AppBar(title: Text(widget.title!)) : null,
      body: PopScope(
        canPop: true,
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}