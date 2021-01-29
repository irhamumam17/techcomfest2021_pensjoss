part of '../pages.dart';

class PaymentWebviewPage extends StatefulWidget {
  @override
  _PaymentWebviewPageState createState() => _PaymentWebviewPageState();
}

class _PaymentWebviewPageState extends State<PaymentWebviewPage> {
  String url = Get.arguments;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarCustom(
            title: 'Pembayaran',
            back: () => Get.offAllNamed('/home'),
          ),
          Expanded(
            child: Builder(
              builder: (BuildContext context) => WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
