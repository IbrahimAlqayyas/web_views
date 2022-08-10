import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';


class InAppPaymentWebView extends StatefulWidget {
  const InAppPaymentWebView({Key? key}) : super(key: key);

  @override
  State<InAppPaymentWebView> createState() => _InAppPaymentWebViewState();
}

class _InAppPaymentWebViewState extends State<InAppPaymentWebView> {

  final GlobalKey webViewKey = GlobalKey();
  String url = "";


  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,

      ));

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: IconButton(icon: Icon(Icons.back_hand), onPressed: () => Navigator.pop(context),),),
      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest:
        URLRequest(url: Uri.parse('https://onelink.to/9htdxh')),
        onUpdateVisitedHistory: (controller, url, androidIsReload) {
          setState(() {
            this.url = url.toString();
          });
        },
        initialOptions: options,
        // pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        // onLoadStart: (controller, url) {
        //   setState(() {
        //     this.url = url.toString();
        //     urlController.text = this.url;
        //   });
        // },
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url!;

          if (![ "http", "https", "file", "chrome",
            "data", "javascript", "about"].contains(uri.scheme)) {
            if (await canLaunch(url)) {
              // Launch the App
              await launch(
                url,
              );
              // and cancel the request
              return NavigationActionPolicy.CANCEL;
            }
          }

          return NavigationActionPolicy.ALLOW;
        },
        // onLoadStop: (controller, url) async {
        //   pullToRefreshController.endRefreshing();
        //   setState(() {
        //     this.url = url.toString();
        //     urlController.text = this.url;
        //   });
        // },
        // onLoadError: (controller, url, code, message) {
        //   pullToRefreshController.endRefreshing();
        // },
        // onProgressChanged: (controller, progress) {
        //   if (progress == 100) {
        //     pullToRefreshController.endRefreshing();
        //   }
        //   setState(() {
        //     this.progress = progress / 100;
        //     urlController.text = this.url;
        //   });
        // },
        // onUpdateVisitedHistory: (controller, url, androidIsReload) {
        //   setState(() {
        //     this.url = url.toString();
        //     urlController.text = this.url;
        //   });
        // },
        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage);
        },
      ),
    );
  }
}