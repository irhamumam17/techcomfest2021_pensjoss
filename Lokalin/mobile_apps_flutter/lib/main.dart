import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karyain/pages/pages.dart';
import 'package:karyain/providers/providers.dart';
import 'package:karyain/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lokalin',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.white,
          brightness: Brightness.light,
          backgroundColor: Colors.grey[300],
          // accentColor: Color(0xFF5F4BC4),
          accentColor: Color(0xFFDC46FE),
          dividerColor: Colors.white54,
          cardColor: Color(0xFFFF7F00),
          errorColor: Color(0xFFCF212A),
          unselectedWidgetColor: Colors.black54,
        ),
        getPages: routes,
        home: SplashScreenPage());
  }
}

class InitialPages extends StatelessWidget {
  const InitialPages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        switch (provider.status) {
          case Status.Uninitialized:
            return InitAuth();
          // case Status.Relogin:
          //   return Loading();
          case Status.Unauthenticated:
            return AuthPage();
          case Status.Authenticated:
            return HomePage();
          default:
            return Loading();
        }
      },
    );
  }
}
