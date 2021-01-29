part of 'pages.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  start() async {
    var _durasi = Duration(seconds: 3);
    return new Timer(_durasi, pageNavigasi);
  }

  PackageInfo packageInfo;

  Future<void> getVersionApp() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = _packageInfo;
    });
  }

  ///ANCHOR: GANTI PAGE NAVIGASI
  void pageNavigasi() {
    Get.offAllNamed('/home');
  }

  @override
  void initState() {
    getVersionApp();
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: SizedBox()),
          Center(
            child: SizedBox(
              width: Get.width / 2,
              child: Image.asset('assets/LOGOTYPE.png'),
            ),
          ),
          Expanded(child: SizedBox()),
          Text(
            'Lokalin v.${packageInfo?.version}',
            style: customTextFont.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Get.theme.primaryColor,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
