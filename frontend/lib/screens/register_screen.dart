import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/controllers/auth_controller.dart';
import 'package:library_management_app/screens/login_screen.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String get username => usernameController.text;
  String get password => passwordController.text;
  String get email => emailController.text;
  String get phoneNumber => phoneNumberController.text;
  String get confirmPassword => confirmPasswordController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(140),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 12,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(LoginScreen());
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 4,
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ]),
            child: _buildRegisterContainer(),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [
        Text(
          'Register',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please input username';
                    }
                    return null;
                  },
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please input email';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please input phone number';
                    }
                    return null;
                  },
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                  ),
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
              ],
            )),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  authController.register(
                      username: username, password: password, email: email);
                  print('username : $username');
                  print('email : $email');
                  print('password : $password');
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  foregroundColor: Colors.white),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 18),
              ),
            ))
          ],
        )
      ],
    );
  }
}
