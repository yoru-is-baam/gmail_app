import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xFFffffff),
    textColor: const Color(0xFF1f1f21),
    fontSize: 16.0,
  );
}
