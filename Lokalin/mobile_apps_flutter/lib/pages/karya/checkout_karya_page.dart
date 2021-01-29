part of '../pages.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Flushbar flush = Flushbar();

  Product product = Get.arguments;

  TextEditingController messageController = TextEditingController();

  bool isLoading = false;

  // Award
  int goldAward = 0;
  int silverAward = 0;
  int bronzeAward = 0;
  int total = 0;

  void countAward(String award, bool isPlus) {
    switch (award) {
      case 'gold':
        if (isPlus) {
          goldAward = goldAward + 1;
          total = total + 100000;
        } else {
          goldAward = goldAward - 1;
          if (goldAward < 0) {
            goldAward = 0;
          } else {
            total = total - 100000;
          }
        }
        setState(() {});
        break;
      case 'silver':
        if (isPlus) {
          silverAward = silverAward + 1;
          total = total + 50000;
        } else {
          silverAward = silverAward - 1;
          if (silverAward < 0) {
            silverAward = 0;
          } else {
            total = total - 50000;
          }
        }
        setState(() {});
        break;
      case 'bronze':
        if (isPlus) {
          bronzeAward = bronzeAward + 1;
          total = total + 10000;
        } else {
          bronzeAward = bronzeAward - 1;
          if (bronzeAward < 0) {
            bronzeAward = 0;
          } else {
            total = total - 10000;
          }
        }
        setState(() {});
        break;
      default:
    }
  }

  void submitCheckout() async {
    flush.dismiss(true);
    FocusScope.of(context).requestFocus(new FocusNode());
    if (total <= 0 || messageController.text.isEmpty) {
      customFlushbar(
        context,
        msg: 'Data harus terisi',
      );
    } else {
      setState(() {
        isLoading = true;
      });
      ApiCek<Transaction> cek =
          await Provider.of<TransactionProvider>(context, listen: false)
              .checkout(
        product.id,
        1,
        total,
        'PENDING',
        messageController.text.toString(),
      );
      if (!cek.isSucces) {
        flush = await customFlushbar(
          Get.context,
          msg: cek.message,
          isRefresh: true,
          function: () => submitCheckout(),
        );
        setState(() {
          isLoading = false;
        });
      } else {
        Get.offAndToNamed('karya/checkout/payment',
            arguments: cek.data.paymentUrl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Get.theme.primaryColor,
        body: Stack(
          children: [
            Column(
              children: [
                AppBarCustom(
                  title: 'Dukung Karya Lokal',
                  back: () => Get.back(),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(child: SizedBox(height: 10)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: mainPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedImageCustom(
                                  image: product.urlPhoto,
                                  height: 170,
                                  width: 120,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: blackTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${product.user.name}',
                                      style: blackTextFont.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Get.theme.cardColor,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      product.description,
                                      style: blackTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 20)),
                      SliverToBoxAdapter(
                          child: Container(
                              height: 10, color: Get.theme.backgroundColor)),
                      SliverToBoxAdapter(child: SizedBox(height: 20)),
                        SliverToBoxAdapter(
                        child: Padding(
                          padding: mainPadding,
                          child: Text(
                            'Award',
                            style: blackTextFont.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height:5)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: mainPadding,
                          child: Text(
                            'Yuk dukung produk ini dengan memberi award',
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: mainPadding,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.grey[300],
                                padding: headerPadding,
                                child: Row(
                                  children: [
                                    Image.asset('assets/gold.png'),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Gold Award',
                                            style: blackTextFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            numberCurrency(100000),
                                            style: blackNumberFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Get.theme.cardColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(MdiIcons.minusCircle,
                                                color: Get.theme.cardColor),
                                            onPressed: () =>
                                                countAward('gold', false),
                                          ),
                                          Text(
                                            '$goldAward',
                                            style: blackNumberFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(MdiIcons.plusCircle,
                                                color: Get.theme.cardColor),
                                            onPressed: () =>
                                                countAward('gold', true),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                color: Colors.grey[300],
                                padding: headerPadding,
                                child: Row(
                                  children: [
                                    Image.asset('assets/silver.png'),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Silver Award',
                                            style: blackTextFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            numberCurrency(50000),
                                            style: blackNumberFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Get.theme.cardColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(MdiIcons.minusCircle,
                                                color: Get.theme.cardColor),
                                            onPressed: () =>
                                                countAward('silver', false),
                                          ),
                                          Text(
                                            '$silverAward',
                                            style: blackNumberFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(MdiIcons.plusCircle,
                                                color: Get.theme.cardColor),
                                            onPressed: () =>
                                                countAward('silver', true),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                color: Colors.grey[300],
                                padding: headerPadding,
                                child: Row(
                                  children: [
                                    Image.asset('assets/bronze.png'),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bronze Award',
                                            style: blackTextFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            numberCurrency(10000),
                                            style: blackNumberFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Get.theme.cardColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(MdiIcons.minusCircle,
                                                color: Get.theme.cardColor),
                                            onPressed: () =>
                                                countAward('bronze', false),
                                          ),
                                          Text(
                                            '$bronzeAward',
                                            style: blackNumberFont.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(MdiIcons.plusCircle,
                                                color: Get.theme.cardColor),
                                            onPressed: () =>
                                                countAward('bronze', true),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 20)),
                      SliverToBoxAdapter(
                          child: Container(
                              height: 10, color: Get.theme.backgroundColor)),
                      SliverToBoxAdapter(child: SizedBox(height: 20)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: mainPadding,
                          child: Text(
                            'Beri Pesan',
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10)),
                      SliverToBoxAdapter(
                        child: TextField(
                          controller: messageController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintStyle: blackTextFont.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).unselectedWidgetColor,
                            ),
                            hintText: 'Tulis pesan..',
                            contentPadding: EdgeInsets.fromLTRB(16, 5, 16, 5),
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            'Total Tagihan',
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[700],
                            ),
                          ),
                            Text(
                              numberCurrency(total),
                              style: blackNumberFont.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Get.theme.cardColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Button(
                          function: submitCheckout,
                          text: 'Bayar',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isLoading) LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
