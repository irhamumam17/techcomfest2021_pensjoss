part of 'widgets.dart';

class Button extends StatelessWidget {
  const Button({
    Key key,
    @required this.function,
    @required this.text,
    this.color,
    this.isBordered = false,
  }) : super(key: key);

  final Function function;
  final String text;
  final Color color;
  final bool isBordered;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: color != null ? color : Get.theme.accentColor,
          border: (isBordered)
              ? Border.all(
                  color: Get.theme.accentColor,
                  width: 1,
                )
              : Border.all(
                  color: Get.theme.primaryColor,
                  width: 0,
                ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: (isBordered)
                ? blackTextFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )
                : whiteTextFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
          ),
        ),
      ),
    );
  }
}
