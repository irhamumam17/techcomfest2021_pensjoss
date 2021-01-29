part of 'widgets.dart';


class ListKaryaWidget extends StatelessWidget {
  const ListKaryaWidget({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed('/karya', arguments: products[index]),
                child: Container(
                  padding: EdgeInsets.all(16),
                  height: 150,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedImageCustom(
                            image: products[index].urlPhoto,
                            width: double.infinity,
                            height: 150,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].name,
                              style: blackTextFont.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              products[index].user.name,
                              style: blackTextFont.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5),
                            LinearPercentIndicator(
                              lineHeight: 3.0,
                              percent: (products[index].totalDonation /
                                          products[index].targetFunding) >
                                      1.0
                                  ? 1.0
                                  : (products[index].totalDonation /
                                      products[index].targetFunding),
                              progressColor: Get.theme.accentColor,
                              backgroundColor: Colors.grey[200],
                              padding: EdgeInsets.all(0),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Terkumpul',
                                  style: blackTextFont.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Sisa hari',
                                  style: blackTextFont.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  numberCurrency(products[index].totalDonation),
                                  style: blackNumberFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Get.theme.cardColor),
                                ),
                                if(pastTime(products[index].targetEnd)>=0)Text(
                                  '${pastTime(products[index].targetEnd)}',
                                  style: blackNumberFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                 if(pastTime(products[index].targetEnd)<0)Text(
                                  'Habis',
                                  style: blackNumberFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Get.theme.errorColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (index != products.length - 1)
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
        childCount: products.length,
      ),
    );
  }
}
