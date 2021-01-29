part of '../pages.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({
    Key key,
    @required this.logout,
  }) : super(key: key);

  final Function logout;
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  Flushbar flush = Flushbar();

  // Fetch My Product
  void getMyProduct() async {
    flush.dismiss(true);
    SharedPreferences storage = await SharedPreferences.getInstance();
    ApiCek<List<Product>> cek =
        await Provider.of<ProductProvider>(context, listen: false)
            .getMyProduct(storage.getInt('id'));
    if (!cek.isSucces) {
      flush = await customFlushbar(
        Get.context,
        msg: cek.message,
        isRefresh: true,
        function: () => getMyProduct(),
      );
    }
  }

  /// NOTE: LIFE CYCLE
  @override
  void initState() {
    super.initState();
    // Fetch Api
    getMyProduct();
  }

  @override
  void dispose() {
    print('Profil page dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.primaryColor,
      child: RefreshIndicator(
        onRefresh: () async => getMyProduct(),
        child: CustomScrollView(
          slivers: [
            Consumer<AuthProvider>(
              builder: (BuildContext context, provider, child) =>
                  SliverToBoxAdapter(
                child: Container(
                  color: Get.theme.primaryColor,
                  child: Padding(
                    padding: mainPadding,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedImageCustom(
                                image: provider.user.profilePhotoUrl,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.user.name,
                                    style: blackTextFont.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    provider.user.email,
                                    style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Get.theme.cardColor),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '${provider.user.description ?? 'Isi biodata kamu..'}',
                                    style: blackTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Button(
                                text: 'Edit Profil',
                                function: () {
                                  Get.toNamed('/pengaturan',
                                      arguments: provider.user);
                                },
                                color: Get.theme.primaryColor,
                                isBordered: true,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Button(
                                text: 'Keluar',
                                function: widget.logout,
                                color: Get.theme.errorColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Button(
                          text: 'Upload Karya',
                          function: () {
                            Get.toNamed('/karya/upload');
                          },
                        ),
                        SizedBox(height: 10),
                        Divider(
                          color: Get.theme.backgroundColor,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Consumer<ProductProvider>(
              builder: (BuildContext context, provider, child) {
                if (provider.myProducts == null) {
                  return SliverToBoxAdapter(
                    child: Container(
                      color: Get.theme.primaryColor,
                      child: loadingSpinkit,
                    ),
                  );
                } else if (provider.myProducts.length == 0) {
                  return SliverToBoxAdapter(
                    child: BlankPageWidget(
                      icon: MdiIcons.shareVariant,
                      title: 'Belum Ada Karya',
                      subtitle:
                          'Kamu belum memiliki karya\nYuk bagikan karya lokal mu sekarang!',
                    ),
                  );
                } else {
                  return ListKaryaWidget(
                    products: provider.myProducts,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
