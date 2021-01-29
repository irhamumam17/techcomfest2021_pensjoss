part of '../pages.dart';

class PengaturanPage extends StatefulWidget {
  @override
  _PengaturanPageState createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  Flushbar flush = Flushbar();
  final picker = ImagePicker();

  bool isLoading = false;

  User user = Get.arguments;

  TextEditingController namaController;
  TextEditingController bioController;

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
    if (namaController.text.isEmpty &&
        bioController.text.isEmpty &&
        image == null) {
      Get.back();
    } else {
      setState(() {
        isLoading = true;
      });
      if (image != null) {
        await Provider.of<UserProvider>(context, listen: false)
            .updatePhotoProfile(file: image);
      }
      ApiCek<User> cek =
          await Provider.of<UserProvider>(context, listen: false).updateProfile(
        name: namaController.text.toString(),
        description: bioController.text.toString(),
      );
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
        await Provider.of<AuthProvider>(context, listen: false)
            .initAuthProvider();
        Get.offAllNamed('/home');
      }
    }
  }

  /// NOTE: LIFE CYCLE
  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: user.name);
    bioController = TextEditingController(text: user.description);
  }

  @override
  void dispose() {
    print('Profil page dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Get.theme.primaryColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarCustom(
                    title: 'Edit Profil',
                    back: () => Get.back(),
                    submit: submit,
                    titleSubmit: 'Simpan',
                    isLoading: false,
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: (image != null)
                          ? Image.file(
                              image,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          : CachedImageCustom(
                              image: user.profilePhotoUrl,
                              height: 120,
                              width: 120,
                            ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: GestureDetector(
                      onTap: () => showImagePicker(context, getImage),
                      child: Text(
                        'Ganti Foto Profil',
                        style: blackTextFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Get.theme.accentColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: mainPadding,
                    child: Text(
                      'Nama',
                      style: blackTextFont.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: mainPadding,
                    child: CustomTextField(
                      judulController: namaController,
                      hint: 'Isi nama...',
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 20),
                  Padding(
                    padding: mainPadding,
                    child: Text(
                      'Bio',
                      style: blackTextFont.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: mainPadding,
                    child: CustomTextField(
                      judulController: bioController,
                      hint: 'Isi bio...',
                      inputType: TextInputType.multiline,
                    ),
                  ),
                  SizedBox(height: 10),
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
