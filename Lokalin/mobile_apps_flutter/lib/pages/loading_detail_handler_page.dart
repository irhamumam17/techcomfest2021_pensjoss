part of 'pages.dart';

class LoadingDetailHandlerPage extends StatefulWidget {
  @override
  _LoadingDetailHandlerPageState createState() =>
      _LoadingDetailHandlerPageState();
}

class _LoadingDetailHandlerPageState extends State<LoadingDetailHandlerPage> {
  Flushbar flush = Flushbar();

  int id = int.parse(Get.parameters['id']);
  String type = Get.parameters['type'];

  // Fetch Product
  void getDetailProducts() async {
    flush.dismiss(true);
    ApiCek<Product> cek =
        await Provider.of<ProductProvider>(context, listen: false)
            .getDetailProducts(id);
    if (!cek.isSucces) {
      flush = await customFlushbar(
        Get.context,
        msg: cek.message,
        isRefresh: true,
        function: () => getDetailProducts(),
      );
    } else {
      Get.offAndToNamed('/karya', arguments: cek.data);
    }
  }

  void fetchHandler() {
    if (type == 'product') {
      getDetailProducts();
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getDetailProducts();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Center(
        child: loadingSpinkit,
      ),
    );
  }
}
