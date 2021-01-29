part of '../pages.dart';

class InitAuth extends StatelessWidget {
  initAuthProvider(context) async {
    Provider.of<AuthProvider>(context).initAuthProvider();
    print('init auth');
  }

  @override
  Widget build(BuildContext context) {
    initAuthProvider(context);

    return Scaffold(
      body: Center(child: loadingSpinkit),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loadingSpinkit,
      ),
    );
  }
}
