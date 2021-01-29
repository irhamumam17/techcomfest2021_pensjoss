part of '../pages.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({
    Key key,
    @required this.emailController,
    @required this.passwordController,
    @required this.signIn,
    @required this.signUp,
    @required this.googleSignIn,
  }) : super(key: key);

  final Function signIn;
  final Function signUp;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GoogleSignIn googleSignIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: mainPadding,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: SizedBox(height: 10)),
          SlideUp(
            0.5,
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Selamat',
                style: blackTextFont.copyWith(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SlideUp(
            0.75,
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Datang',
                style: blackTextFont.copyWith(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(flex: 3, child: SizedBox(height: 10)),
          FadeInUp(
            1,
            TextField(
              keyboardType: TextInputType.text,
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: blackTextFont.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.withOpacity(0.7)),
                prefixIcon: Icon(Icons.email, color: Get.theme.accentColor),
                filled: true,
                fillColor: Get.theme.backgroundColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeInUp(
            1,
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: blackTextFont.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.withOpacity(0.7)),
                prefixIcon: Icon(Icons.lock, color: Get.theme.accentColor),
                filled: true,
                fillColor: Get.theme.backgroundColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeInUp(
            1,
            InkWell(
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.theme.accentColor,
                ),
                child: Text(
                  'Masuk',
                  style: whiteTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                signIn();
              },
            ),
          ),
          SizedBox(height: 10),
          // FadeInUp(
          //   1,
          //   InkWell(
          //       child: Container(
          //         height: 50,
          //         width: double.infinity,
          //         alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: Get.theme.accentColor,
          //         ),
          //         child: Text(
          //           'Google',
          //           style: whiteTextFont.copyWith(
          //               fontSize: 16, fontWeight: FontWeight.w500),
          //         ),
          //       ),
          //       onTap: () {
          //         try {
          //           googleSignIn.signIn().then((result) {
          //             result.authentication.then((googleKey) {
          //               print(googleKey.accessToken);
          //               print(googleKey.idToken);
          //               print(googleSignIn.currentUser.displayName);
          //             }).catchError((err) {
          //               print('inner error');
          //             });
          //           }).catchError((err) {
          //             print('error occured');
          //           });
          //         } catch (e) {
          //           print(e);
          //         }
          //       }),
          // ),
          SizedBox(height: 10),
          FadeInUp(
            1.25,
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Belum punya akun? ",
                      style: blackTextFont.copyWith(
                          fontSize: 14, color: Colors.grey.withOpacity(0.7))),
                  Text('Daftar Sekarang!',
                      style: blackTextFont.copyWith(
                          fontSize: 14, color: Get.theme.accentColor)),
                ],
              ),
              onTap: () {
                signUp();
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
