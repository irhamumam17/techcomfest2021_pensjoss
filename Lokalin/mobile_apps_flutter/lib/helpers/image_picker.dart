part of 'helpers.dart';

Future<void> showImagePicker(BuildContext context, Function getImage) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      elevation: 10.0,
      context: context,
      backgroundColor: Get.theme.backgroundColor,
      isScrollControlled: true,
      builder: (builder) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.0),
                height: 50.0,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Pilih Foto',
                    style: customTextFont.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            MdiIcons.camera,
                            color: Get.theme.accentColor,
                            size: 50,
                          ),
                          Text(
                            'Kamera',
                            style: customTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Get.theme.unselectedWidgetColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          getImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              MdiIcons.folder,
                              color: Get.theme.accentColor,
                              size: 50,
                            ),
                            Text(
                              'Galeri',
                              style: customTextFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Get.theme.unselectedWidgetColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      });
}
