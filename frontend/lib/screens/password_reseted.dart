import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/screens/login_screen.dart';
import 'package:library_management_app/widgets/custom_button.dart';

class PasswordReseted extends StatelessWidget {
  const PasswordReseted({super.key});

  final imagePath = 'assets/logo/security-verification.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          spacing: 20,
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(imagePath),
            Column(
              spacing: 12,
              children: [
                Text(
                  'Password Reset',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Your password has been reset successfully Now login with your new password',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Spacer(),
            CustomButton(
                title: 'Login',
                onPressed: () {
                  Get.to(LoginScreen());
                }),
          ],
        ),
      ),
    );
  }
}
