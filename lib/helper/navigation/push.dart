import 'package:flutter/material.dart';

Future<void> pushTo(BuildContext context, Widget screen) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
