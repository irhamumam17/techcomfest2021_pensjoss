part of '../pages.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Size layar
  double get maxWidht => MediaQuery.of(context).size.width;
  double get maxHeight => MediaQuery.of(context).size.height;

  // Animasi
  bool isSignIn = true;
  bool isLoading = false;

  // Text Field
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  // Google Sign in
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              ///NOTE: BACKGROUND
              SlideDown(
                0.5,
                ClipPath(
                  clipper: CustomClipPath1(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Get.theme.accentColor,
                            Get.theme.accentColor,
                          ],
                          stops: [
                            0.0,
                            1.0
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          tileMode: TileMode.repeated),
                    ),
                  ),
                ),
              ),

              ///NOTE: VIEW
              (!isSignIn)
                  ? SignupPage(
                      signIn: signIn,
                      signUp: signUp,
                      emailController: emailController,
                      passwordController: passwordController,
                      nameController: nameController,
                      nomorController: passwordConfirmationController,
                    )
                  : SigninPage(
                      signIn: signIn,
                      signUp: signUp,
                      emailController: emailController,
                      passwordController: passwordController,
                      googleSignIn: _googleSignIn,
                    ),

              ///NOTE: LOADING
              if (isLoading) LoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (isSignIn) {
      FocusScope.of(context).requestFocus(new FocusNode());
      if (emailController.text.length > 0 &&
          passwordController.text.length > 0) {
        setState(() {
          isLoading = true;
        });
        ApiCek<User> _result =
            await Provider.of<AuthProvider>(context, listen: false).signin(
                emailController.text.trim(),
                passwordController.text.toString());

        if (!_result.isSucces) {
          customFlushbar(context, msg: _result.message);
          setState(() {
            isLoading = false;
          });
        }
      } else {
        customFlushbar(context, msg: 'Email dan password tidak boleh kosong');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isSignIn = true;
      });
      resetTextField();
    }
  }

  void signUp() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!isSignIn) {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          passwordConfirmationController.text.isNotEmpty &&
          passwordController.text.length >= 8) {
        setState(() {
          isLoading = true;
        });
        ApiCek<User> _result =
            await Provider.of<AuthProvider>(context, listen: false).register(
          name: nameController.text,
          email: emailController.text.trim(),
          password: passwordController.text.toString(),
          passwordConfirmation: passwordConfirmationController.text.toString(),
        );

        if (!_result.isSucces) {
          customFlushbar(context, msg: _result.message);
          setState(() {
            isLoading = false;
          });
        }
      } else if (passwordConfirmationController.text !=
          passwordController.text) {
        customFlushbar(context, msg: 'Password tidak sama');
        setState(() {
          isLoading = false;
        });
      } else if (passwordController.text.length < 8) {
        customFlushbar(context, msg: 'Password minimal 8 karakter');
        setState(() {
          isLoading = false;
        });
      } else {
        customFlushbar(context, msg: 'Data tidak boleh kosong');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isSignIn = false;
      });
      resetTextField();
    }
  }

  void resetTextField() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    passwordConfirmationController.clear();
  }

  Text heading(String text) {
    return Text(
      text,
      style: blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
