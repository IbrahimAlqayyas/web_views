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

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    print('/// INIT: ---------');
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    } else if(Platform.isIOS) {
      print(WebView.platform);
      // print(WK);

    }
  }

  @override
  Widget build(BuildContext context) {
    // String url = '${ModalRoute.of(context)!.settings.arguments}';´
    String url = 'https://secure.paytabs.sa/payment/page/5816FBD382E475B1FF4913D433F36CC34CD1863AD2FA4558873F2582';
    // String url = 'https://www.google.com';

    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(

          initialUrl: url,

          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
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
