import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/screens/password_reseted.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key});

  final imagePath = 'assets/logo/security-illustration.png';
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String get password => passwordController.text;
  String get confirmPassword => confirmPasswordController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'New Password',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .2,
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(140))),
                    ),
                  )
                ],
              ),
              Spacer(),
              Image.asset(imagePath)
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 4,
                      )
                    ]),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
                      Text(
                        'Enter new password',
                        style: TextStyle(fontSize: 22),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Please input password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key_sharp),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ))),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Please input confirm password';
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key_sharp),
                            hintText: 'Confirm Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ))),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print('password : $password');
                                print('confirm password : $confirmPassword');
                                Get.to(PasswordReseted());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                foregroundColor: Colors.white),
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18),
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
