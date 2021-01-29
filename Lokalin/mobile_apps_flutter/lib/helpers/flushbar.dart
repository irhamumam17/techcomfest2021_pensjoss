part of 'helpers.dart';

Future<Flushbar<bool>> customFlushbar(
  BuildContext context, {
  String msg,
  Color color = const Color(0xFFCF212A),
  bool isRefresh = false,
  Function function,
  title = 'Refresh',
}) async {
  try {
    if (isRefresh) {
      return Flushbar<bool>(
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: 10,
        margin: EdgeInsets.only(top:10, left:16,right:16),
        mainButton: TextButton(
          onPressed: function,
          child: Text(
            title,
            style: whiteTextFont.copyWith(fontSize: 16),
          ),
        ),
        backgroundColor: color,
        message: msg,
      )..show(context);
    } else {
      return Flushbar<bool>(
        duration: Duration(milliseconds: 2000),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: color,
        borderRadius: 10,
        margin: EdgeInsets.only(top:10, left:16,right:16),
        message: msg,
      )..show(context);
    }
  } catch (e) {
    return null;
  }
}
