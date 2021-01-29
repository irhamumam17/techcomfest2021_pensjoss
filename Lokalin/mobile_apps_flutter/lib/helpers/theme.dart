part of 'helpers.dart';

Color mainColor = Colors.blue;

EdgeInsets mainPadding = EdgeInsets.symmetric(horizontal: 16);
EdgeInsets headerPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 20);

TextStyle customTextFont =
    GoogleFonts.roboto().copyWith(fontWeight: FontWeight.w500);
TextStyle blackTextFont = GoogleFonts.roboto()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.roboto()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);

TextStyle customNumberFont = GoogleFonts.openSans().copyWith();
TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle blackNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.black);

final loadingSpinkit =
    SpinKitThreeBounce(color: Get.theme.accentColor, size: 25.0);
