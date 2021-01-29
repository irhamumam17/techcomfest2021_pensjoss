part of '../pages.dart';

class UploadKaryaPage extends StatefulWidget {
  @override
  _UploadKaryaPageState createState() => _UploadKaryaPageState();
}

class _UploadKaryaPageState extends State<UploadKaryaPage> {
  Flushbar flush = Flushbar();
  final picker = ImagePicker();

  bool isLoading = false;

  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();

  // Target End
  DateTime selectedDate = DateTime.now().add(Duration(days: 31));

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().add(Duration(days: 10)),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Money Text Field
  TextEditingController moneyController = TextEditingController();
  static const _locale = 'id';

  String _formatNumber(String string) {
    final format = NumberFormat.decimalPattern(_locale);
    return format.format(int.parse(string));
  }

  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  File image;

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  void submit() async {
    flush.dismiss(true);
    FocusScope.of(context).requestFocus(new FocusNode());
    if (judulController.text.isEmpty &&
        moneyController.text.isEmpty &&
        deskripsiController.text.isEmpty) {
      customFlushbar(
        context,
        msg: 'Data harus terisi',
      );
    } else {
      setState(() {
        isLoading = true;
      });
      ApiCek<Product> cek =
          await Provider.of<ProductProvider>(context, listen: false)
              .createProduct(
                  judulController.text.toString(),
                  deskripsiController.text.toString(),
                  '',
                  moneyController.text.replaceAll('.', ''),
                  selectedDate.toString(),
                  youtubeController.text.toString(),
                  image);
      if (!cek.isSucces) {
        flush = await customFlushbar(
          Get.context,
          msg: cek.message,
          isRefresh: true,
          function: () => submit(),
        );
        setState(() {
          isLoading = false;
        });
      } else {
        Get.offAndToNamed('/loading?id=${cek.data.id}&type=product');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Get.theme.backgroundColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarCustom(
                    title: 'Upload Karya',
                    back: () => Get.back(),
                    submit: submit,
                    isLoading: false,
                  ),
                  Container(
                    height: 350,
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Foto',
                          style: blackTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => showImagePicker(context, getImage),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: Colors.grey[300],
                                margin: EdgeInsets.symmetric(vertical: 5),
                                alignment: Alignment.center,
                                child: (image != null)
                                    ? Image.file(
                                        image,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        MdiIcons.camera,
                                        size: 40,
                                        color: Get.theme.accentColor,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Video',
                          style: blackTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          judulController: youtubeController,
                          hint: 'Tulis Link Video Youtube...',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Get.theme.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Target Dana',
                          style: blackTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextField(
                          controller: moneyController,
                          decoration: InputDecoration(
                            prefixText: currency,
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Isi nominal..',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (string) {
                            string = '${_formatNumber(string.replaceAll('.', ''))}';
                            moneyController.text = string;
                            Timer(
                              Duration(milliseconds: 1),
                              () {
                                moneyController.selection =
                                    TextSelection.fromPosition(
                                        TextPosition(offset: string.length));
                              },
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tanggal Berakhir',
                          style: blackTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${pastTime(selectedDate)} Hari lagi',
                                    style: blackTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Karya',
                          style: blackTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          judulController: judulController,
                          hint: 'Tulis Nama Karya...',
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          judulController: deskripsiController,
                          hint: 'Tulis Deskripsi...',
                          inputType: TextInputType.multiline,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
             if (isLoading) LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
