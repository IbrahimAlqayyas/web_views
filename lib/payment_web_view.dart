import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({Key? key}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    print('/// INIT: ---------');
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    } else if(Platform.isIOS) {
      // WebView.platform.build(context: context, creationParams: creationParams, webViewPlatformCallbacksHandler: webViewPlatformCallbacksHandler, javascriptChannelRegistry: javascriptChannelRegistry);
      // print(WK);

    }
  }

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context)!.settings.arguments as String;
    // String url = 'https://secure.paytabs.sa/payment/page/5816FBD382E475B1FF4913D433F36CC34CD1863AD2FA4558873F2582';
    // String url = 'https://www.google.com';

    return Scaffold(
      appBar: AppBar(
        title: Text(url),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(

          initialUrl: Uri.encodeFull(url),

          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            print(url);
            return NavigationDecision.navigate;
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
}
