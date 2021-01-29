import 'dart:convert';
import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

part 'api_endpoint.dart';
part 'theme.dart';
part 'flushbar.dart';
part 'image_picker.dart';
part 'time_ago.dart';
part 'validate_response_status.dart';
part 'animation.dart';
part 'currency_input_formater.dart';

// Auth Token
String token = '';

// Number Currency
numberCurrency(int number) {
  return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
      .format(number);
}

