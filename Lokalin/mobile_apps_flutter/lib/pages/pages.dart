

import 'dart:async';
import 'dart:io';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:karyain/helpers/helpers.dart';
import 'package:karyain/models/models.dart';
import 'package:karyain/providers/providers.dart';
import 'package:karyain/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'loading_detail_handler_page.dart';
part 'splash_screen_page.dart';
part 'auth/signin_page.dart';
part 'auth/signup_page.dart';
part 'auth/auth_page.dart';
part 'auth/init_auth_page.dart';
part 'home/home_page.dart';
part 'home/main_page.dart';
part 'home/riwayat_page.dart';
part 'home/akun_page.dart';
part 'home/pengaturan_page.dart';
part 'karya/detail_karya_page.dart';
part 'karya/checkout_karya_page.dart';
part 'karya/payment_webview_page.dart';
part 'karya/upload_karya_page.dart';