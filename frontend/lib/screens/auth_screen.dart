import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/screens/login_screen.dart';
import 'package:library_management_app/screens/register_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Text('Auth Screen',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Get.to(LoginScreen());
                      },
                      child: Text('Login'))),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Get.to(RegisterScreen());
                      },
                      child: Text('Register')))
            ],
          )
        ],
      ),
    ));
  }
}
