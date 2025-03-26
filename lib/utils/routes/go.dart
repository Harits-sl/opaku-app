import 'package:flutter/material.dart';

class Go {
  static void to({
    required BuildContext context,
    required String path,
    dynamic arguments,
  }) {
    Navigator.of(context).pushNamed(path, arguments: arguments);
  }

  static void back(BuildContext context) {
    Navigator.pop(context);
  }
}
