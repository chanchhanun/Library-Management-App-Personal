import 'package:flutter/material.dart';

import '../constants/color_const.dart';

Widget CustomButton({required Function() onPressed, required String title}) {
  return Row(
    children: [
      Expanded(
          child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(12),
            backgroundColor: primaryColor,
            foregroundColor: Colors.white),
        child: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
      ))
    ],
  );
}
