import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common/theme.dart';

toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: primaryDarkerLightColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
