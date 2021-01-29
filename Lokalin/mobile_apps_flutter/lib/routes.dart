import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karyain/main.dart';
import 'package:karyain/pages/pages.dart';

List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => SplashScreenPage(),
    transition: Transition.rightToLeftWithFade,
    curve: Curves.easeOut,
  ),
  
  GetPage(
    name: '/home',
    page: () => InitialPages(),
    transition: Transition.rightToLeftWithFade,
    curve: Curves.easeOut,
  ),

  GetPage(
    name: '/loading',
    page: () => LoadingDetailHandlerPage(),
    transition: Transition.rightToLeftWithFade,
    curve: Curves.easeOut,
  ),

  GetPage(
    name: '/pengaturan',
    page: () => PengaturanPage(),
    transition: Transition.rightToLeftWithFade,
    curve: Curves.easeOut,
  ),

  // Karya
  GetPage(
    name: '/karya',
    page: () => DetailKaryaPage(),
    transition: Transition.rightToLeftWithFade,
    curve: Curves.easeOut,
  ),

  GetPage(
    name: '/karya/checkout',
    page: () => CheckoutPage(),
    transition: Transition.rightToLeftWithFade,
    curve: Curves.easeOut,
  ),

  GetPage(
    name: '/karya/checkout/payment',
    page: () => PaymentWebviewPage(),
    transition: Transition.rightToLeftWithFade,
    curve: Curves.easeOut,
  ),

  GetPage(
    name: '/karya/upload',
    page: () => UploadKaryaPage(),
    transition: Transition.rightToLeftWithFade,
    curve: Curves.easeOut,
  ),
];
