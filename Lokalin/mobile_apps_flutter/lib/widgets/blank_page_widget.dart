part of 'widgets.dart';


class BlankPageWidget extends StatelessWidget {
  const BlankPageWidget({
    Key key,
    this.icon,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,size:100,color: Get.theme.accentColor),
          SizedBox(height: 20),
          Text(
            title,
            style: blackTextFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: mainPadding,
            child: Text(
              subtitle,
              style: blackTextFont.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
