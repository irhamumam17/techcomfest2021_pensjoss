import 'dart:convert';
import 'dart:io';

import 'package:karyain/helpers/helpers.dart';
import 'package:karyain/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'api/auth_api_repository.dart';
part 'api/product_api_repository.dart';
part 'local/auth_local_repository.dart';
part 'api/transaction_api_repository.dart';
part 'api/user_api_repository.dart';