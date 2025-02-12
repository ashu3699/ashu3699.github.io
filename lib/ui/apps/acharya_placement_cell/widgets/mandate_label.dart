import 'package:flutter/material.dart';

Widget mandateLabel(String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(label),
      const Text(
        '*',
        style: TextStyle(color: Colors.red),
      )
    ],
  );
}
