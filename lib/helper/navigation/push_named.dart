import 'package:flutter/material.dart';

Future<void> pushNamed(
  BuildContext context,
  String namedScreen,
) async {
  await Navigator.pushNamed(
    context,
    namedScreen,
  );
}
