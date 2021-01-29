part of 'widgets.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    Key key,
    @required this.title,
    this.titleSubmit = 'Kirim',
    this.back,
    this.submit,
    this.isLoading,
    this.icon,
    this.withBorder = false,
    this.titleOnly = false,
  }) : super(key: key);

  final String title;
  final String titleSubmit;
  final Function back;
  final Function submit;
  final Icon icon;
  final bool isLoading;
  final bool titleOnly;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: (withBorder)
            ? BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              )
            : BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
        padding: (titleOnly) ? mainPadding : EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!titleOnly)
              IconButton(
                icon: Icon(MdiIcons.chevronLeft),
                onPressed: back ?? () => Get.back(),
              ),
            Expanded(
              child: SizedBox(
                child: Text(
                  title,
                  style: customTextFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            if (submit != null)
              (isLoading)
                  ? loadingSpinkit
                  : GestureDetector(
                      onTap: submit,
                      child: (icon != null)
                          ? icon
                          : Text(
                              titleSubmit,
                              style: customTextFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.theme.accentColor,
                              ),
                            ),
                    ),
            SizedBox(width: 16),
            if (titleOnly)
              IconButton(
                icon: Icon(
                  MdiIcons.chevronLeft,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: back ?? () => Get.back(),
              ),
          ],
        ),
      ),
    );
  }
}
