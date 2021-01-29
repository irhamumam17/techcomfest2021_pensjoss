part of '../pages.dart';

class DetailKaryaPage extends StatefulWidget {
  @override
  _DetailKaryaPageState createState() => _DetailKaryaPageState();
}

class _DetailKaryaPageState extends State<DetailKaryaPage> {
  Product product = Get.arguments;

  // video
  YoutubePlayerController _controller;

  setYoutubePlayer() {
    try {
      String initialVideoId = YoutubePlayer.convertUrlToId(product.videoPath);
      if (product.videoPath != null && initialVideoId != null) {
        _controller = YoutubePlayerController(
          initialVideoId: initialVideoId,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    setYoutubePlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Column(
        children: [
          AppBarCustom(
            title: 'Karya',
            back: () => Get.back(),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Get.theme.primaryColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedImageCustom(
                            image: product.urlPhoto,
                            width: double.infinity,
                            height: 250,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: mainPadding,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedImageCustom(
                                image: product.user.profilePhotoUrl,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
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
                                SizedBox(height: 5),
                                Text(
                                  '${product.user.name}',
                                  style: blackTextFont.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Get.theme.cardColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: mainPadding,
                        child: Row(
                          children: [
                            Text(
                              '${product.donator.length}',
                              style: blackNumberFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              ' Pendukung',
                              style: blackTextFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            if (pastTime(product.targetEnd) >= 0)
                              Text(
                                '${pastTime(product.targetEnd)}',
                                style: blackNumberFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            if (pastTime(product.targetEnd) < 0)
                              Text(
                                'Waktu Habis',
                                style: blackNumberFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Get.theme.errorColor,
                                ),
                              ),
                            if (pastTime(product.targetEnd) >= 0)
                              Text(
                                ' hari lagi',
                                style: blackTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: LinearPercentIndicator(
                          lineHeight: 5.0,
                          percent: (product.totalDonation /
                                      product.targetFunding) >
                                  1.0
                              ? 1.0
                              : (product.totalDonation / product.targetFunding),
                          progressColor: Get.theme.accentColor,
                          backgroundColor: Colors.grey[200],
                          padding: EdgeInsets.all(0),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: mainPadding,
                        child: Text(
                          numberCurrency(product.totalDonation),
                          style: blackNumberFont.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Get.theme.cardColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: mainPadding,
                        child: Text(
                          'Terkumpul dari ${numberCurrency(product.targetFunding)}',
                          style: blackNumberFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(height: 10, color: Get.theme.backgroundColor),
                      if (product.videoPath != null && _controller != null) ...[
                        Container(
                          padding: headerPadding,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Video',
                                style: blackTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              YoutubePlayer(
                                controller: _controller,
                                showVideoProgressIndicator: true,
                              ),
                            ],
                          ),
                        ),
                        Container(height: 10, color: Get.theme.backgroundColor),
                      ],
                      Container(
                        padding: headerPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deskripsi',
                              style: blackTextFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
                            ),
                          ],
                        ),
                      ),
                      Container(height: 10, color: Get.theme.backgroundColor),
                      Container(
                        padding: headerPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pendukung',
                              style: blackTextFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: mainPadding,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            margin: EdgeInsets.only(bottom:10),
                            padding: headerPadding,
                            color: Colors.grey[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedImageCustom(
                                    image: product
                                        .donator[index].user.profilePhotoUrl,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.donator[index].user.name,
                                        style: blackTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        numberCurrency(
                                            product.donator[index].total),
                                        style: blackNumberFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Get.theme.cardColor,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${timeAgo(product.donator[index].createdAt)}',
                                        style: blackTextFont.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        product.donator[index].message,
                                        style: blackTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: product.donator.length,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Button(
              function: () {
                if (pastTime(product.targetEnd) < 0) {
                  customFlushbar(
                    context,
                    msg: 'Waktu telah habis',
                  );
                } else {
                  Get.toNamed('/karya/checkout', arguments: product);
                }
              },
              text: 'Dukung Karya',
            ),
          ),
        ],
      ),
    );
  }
}
