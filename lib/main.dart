import 'package:flutter/material.dart';
import 'package:web_view/payment_web_view.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'in_app_browser.dart';
import 'in_app_webview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/payment-webview': (context) => const PaymentWebView(),
        '/webview': (context) => const InAppPaymentWebView(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void openWebView() {

    // String url = 'https://secure.paytabs.sa/payment/page/5816FE4182E476EABBA9E9257F204F5CBF9197EB1833758E5F5B1E08';// Navigator.of(context).pushNamed('/webview', arguments: url);
    // String url = 'https://secure.paytabs.sa/payment/page/5816FBD382E475B1FF4913D433F36CC34CD1863AD2FA4558873F2582';// Navigator.of(context).pushNamed('/webview', arguments: url);
    String url = 'https://onelink.to/9htdxh';
    // String url = 'https://google.com';

    print(url);

    /// #1
    // Navigator.of(context).pushNamed('/webview');

    /// #2
    // Navigator.of(context).pushNamed('/payment-webview', arguments: url);

    /// #3
    final ChromeSafariBrowser browser = MyChromeSafariBrowser();


    browser.open(
      url: Uri.parse(url),
      options: ChromeSafariBrowserClassOptions(
        android: AndroidChromeCustomTabsOptions(shareState: CustomTabsShareState.SHARE_STATE_OFF),
        ios: IOSSafariOptions(barCollapsingEnabled: true,
            preferredBarTintColor: Colors.teal,
          dismissButtonStyle: IOSSafariDismissButtonStyle.CLOSE,
          preferredControlTintColor: Colors.white,
          presentationStyle: IOSUIModalPresentationStyle.FULL_SCREEN,
        ),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FloatingActionButton(
          onPressed: openWebView,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
