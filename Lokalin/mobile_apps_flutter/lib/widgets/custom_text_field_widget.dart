part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.judulController,
    this.hint,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  final TextEditingController judulController;
  final String hint;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      TextSpan text = new TextSpan(
        text: judulController.text,
        style: customTextFont.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      );

      TextPainter tp = new TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
      );
      tp.layout(maxWidth: size.maxWidth);

      int lines = (tp.size.height / tp.preferredLineHeight).ceil();
      int maxLines = 10;

      return TextField(
        controller: judulController,
        keyboardType: inputType,
        maxLines: lines < maxLines ? null : maxLines,
        decoration: InputDecoration(
          hintStyle: blackTextFont.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          hintText: hint,
          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          border: UnderlineInputBorder(
            borderSide:  BorderSide(
              color: Get.theme.backgroundColor,
            ),
          ),
        ),
      );
    });
  }
}
