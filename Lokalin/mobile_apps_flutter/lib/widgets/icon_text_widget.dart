part of 'widgets.dart';


class IconText extends StatelessWidget {
  const IconText({
    Key key,
    this.text,
    this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Get.theme.accentColor,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Get.theme.accentColor,
            ),
          )
        ],
      ),
    );
  }
}
