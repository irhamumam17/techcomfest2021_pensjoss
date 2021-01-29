part of '../pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Flushbar flush = Flushbar();

  // Carousel Banner
  PageController pageController;
  int indexCarousel = 0;
  Timer _timer;
  int totalPage = 5;

  // Fetch Product
  void getProducts() async {
    flush.dismiss(true);
    ApiCek<List<Product>> cek =
        await Provider.of<ProductProvider>(context, listen: false)
            .getProducts();
    if (!cek.isSucces) {
      flush = await customFlushbar(
        Get.context,
        msg: cek.message,
        isRefresh: true,
        function: () => getProducts(),
      );
    }
  }

  /// NOTE: LIFE CYCLE
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (indexCarousel < totalPage - 1) {
        indexCarousel++;
      } else {
        indexCarousel = 0;
      }
      pageController.animateToPage(indexCarousel,
          duration: Duration(milliseconds: 600), curve: Curves.easeInOut);
    });

    // Fetch Api
    getProducts();
  }

  @override
  void dispose() {
    _timer.cancel();
    pageController.dispose();
    print('Main page dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => getProducts(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 220,
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 20),
              margin: EdgeInsets.only(bottom: 10),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: pageController,
                    itemCount: totalPage,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/banner-$index.png',
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: SmoothPageIndicator(
                          controller: pageController,
                          count: totalPage,
                          effect: WormEffect(
                            activeDotColor: Get.theme.accentColor,
                            dotColor: Colors.white,
                            dotHeight: 10,
                            dotWidth: 10,
                          ),
                          onDotClicked: (index) {}),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer<ProductProvider>(
            builder: (BuildContext context, provider, child) {
              if (provider.products == null) {
                return SliverToBoxAdapter(
                  child: Container(
                    height: Get.height / 2,
                    alignment: Alignment.center,
                    child: loadingSpinkit,
                  ),
                );
              } else {
                return ListKaryaWidget(
                  products: provider.products,
                );
              }
            },
          ),
          // SliverToBoxAdapter(child:SizedBox(height:1000))
        ],
      ),
    );
  }
}
