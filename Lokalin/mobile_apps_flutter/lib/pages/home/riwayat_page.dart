part of '../pages.dart';

class RiwayatPage extends StatefulWidget {
  @override
  _RiwayatPageState createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  Flushbar flush = Flushbar();

  // Fetch Transaction
  void getTransaction() async {
    flush.dismiss(true);
    ApiCek<List<Transaction>> cek =
        await Provider.of<TransactionProvider>(context, listen: false)
            .getTransaction();
    if (!cek.isSucces) {
      flush = await customFlushbar(
        Get.context,
        msg: cek.message,
        isRefresh: true,
        function: () => getTransaction(),
      );
    }
  }

  /// NOTE: LIFE CYCLE
  @override
  void initState() {
    super.initState();
    // Fetch Api
    getTransaction();
  }

  @override
  void dispose() {
    print('Riwayat page dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (BuildContext context, provider, child) {
        if (provider.transactions == null) {
          return Container(
            color: Get.theme.primaryColor,
            child: loadingSpinkit,
          );
        } else if (provider.transactions.length == 0) {
          return BlankPageWidget(
            icon: MdiIcons.history,
            title: 'Belum Ada Riwayat',
            subtitle:
                'Kamu belum memiliki riwayat\nYuk mulai dukung karya lokal sekarang!',
          );
        } else {
          return Container(
            color: Get.theme.primaryColor,
            child: RefreshIndicator(
              onRefresh: () async => getTransaction(),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (provider.transactions[index].status ==
                                    'PENDING') {
                                  Get.toNamed('karya/checkout/payment',
                                      arguments: provider
                                          .transactions[index].paymentUrl);
                                } else {
                                  Get.toNamed(
                                      '/loading?id=${provider.transactions[index].product.id}&type=product');
                                }
                              },
                              child: Container(
                                padding: headerPadding,
                                color: Get.theme.primaryColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedImageCustom(
                                        image: provider.transactions[index]
                                            .product.urlPhoto,
                                        height: 150,
                                        width: 100,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider.transactions[index].product
                                                .name,
                                            style: blackTextFont.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Nominal',
                                                style: blackTextFont.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                              Text(
                                                'Status',
                                                style: blackTextFont.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${numberCurrency(provider.transactions[index].total)}',
                                                style: blackNumberFont.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: provider
                                                              .transactions[
                                                                  index]
                                                              .status ==
                                                          'SUCCESS'
                                                      ? Get.theme.cardColor
                                                      : Get.theme.errorColor,
                                                ),
                                              ),
                                              Text(
                                                '${provider.transactions[index].status.toLowerCase()}',
                                                style: blackTextFont.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: provider
                                                              .transactions[
                                                                  index]
                                                              .status ==
                                                          'SUCCESS'
                                                      ? Get.theme.cardColor
                                                      : Get.theme.errorColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Pesan',
                                            style: blackTextFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          Text(
                                            provider
                                                .transactions[index].message,
                                            style: blackTextFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '${timeAgo(provider.transactions[index].createdAt)}',
                                            style: blackTextFont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (index != provider.transactions.length - 1)
                              Container(
                                color: Colors.white,
                                padding: mainPadding,
                                child: Divider(
                                  color: Get.theme.backgroundColor,
                                  thickness: 1,
                                ),
                              ),
                          ],
                        );
                      },
                      childCount: provider.transactions.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
