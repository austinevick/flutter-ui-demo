import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void showSnackbar(String text) =>
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue.shade800),
            const SizedBox(width: 8),
            Expanded(child: Text(text))
          ],
        )));
