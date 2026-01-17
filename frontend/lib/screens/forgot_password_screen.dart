import 'package:flutter/material.dart';
import 'package:library_management_app/constants/color_const.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final forgotPasswordImagePath = 'assets/logo/wrong-password-illustration.png';
  final logoPath = 'assets/logo/Logolibrary1.png';
  final emailController = TextEditingController();
  String get email => emailController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .3,
                color: primaryColor,
              ),
              Spacer(),
              Image.asset(forgotPasswordImagePath)
            ],
          ),
          Positioned(
              child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 4)
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 22,
              children: [
                Image.asset(
                  logoPath,
                  width: 140,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Enter your email address below to reset the password',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Please input email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)))),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Text(
                          'Continue',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
