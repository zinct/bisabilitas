///
/// webview_widget.dart
/// lib/core/widgets
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../resources/colors.dart';

class WebViewWidget extends StatefulWidget {
  final Uri initialURI;
  final void Function(InAppWebViewController, Uri?, bool?)?
      onUpdateVisitedHistory;
  final void Function(InAppWebViewController, int)? onProgressChanged;
  final void Function(InAppWebViewController, Uri?)? onLoadStart;
  final void Function(InAppWebViewController, Uri?)? onLoadStop;
  final void Function(InAppWebViewController, ConsoleMessage)? onConsoleMessage;

  const WebViewWidget({
    super.key,
    required this.initialURI,
    this.onUpdateVisitedHistory,
    this.onProgressChanged,
    this.onLoadStart,
    this.onLoadStop,
    this.onConsoleMessage,
  });

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final GlobalKey webViewKey = GlobalKey();

  late InAppWebViewController webViewController;
  late PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            options: PullToRefreshOptions(
              color: BaseColors.primary,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController.canGoBack()) {
          await webViewController.goBack();
          return false;
        }

        return true;
      },
      child: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(url: widget.initialURI),
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
              supportZoom: false,
            ),
            android: AndroidInAppWebViewOptions(
              builtInZoomControls: false,
              allowContentAccess: true,
            ),
            ios: IOSInAppWebViewOptions()),
        pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onConsoleMessage: widget.onConsoleMessage,
        onLoadError: (controller, url, code, message) {
          pullToRefreshController!.endRefreshing();
        },
        onLoadStart: widget.onLoadStart,
        onLoadStop: widget.onLoadStop,
        onProgressChanged: widget.onProgressChanged,
        onUpdateVisitedHistory: widget.onUpdateVisitedHistory,
      ),
    );
  }
}
