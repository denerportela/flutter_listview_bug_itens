import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<T> getAppRoute<T>(Widget page) {
    return CupertinoPageRoute<T>(builder: (BuildContext context) => page);
  }
}