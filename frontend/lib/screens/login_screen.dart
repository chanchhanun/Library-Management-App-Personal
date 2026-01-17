import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/controllers/auth_controller.dart';
import 'package:library_management_app/screens/new_password_screen.dart';
import 'package:library_management_app/screens/register_screen.dart';

import '../services/google/auth_service.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String get username => usernameController.text;
  String get password => passwordController.text;
  var isVisibled = false;
  final facebookImagePath = 'assets/icon/facebook.png';
  final googleImagePath = 'assets/icon/google-logo.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))
            : null,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              _buildBackground(),
              Column(
                spacing: 12,
                children: [
                  _buildLoginContainer(),
                  Text(
                    'Or Login With',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 16,
                      children: [
                        _buildLoginWith(
                          title: 'Continue With Google',
                          imagePath: googleImagePath,
                          onPressed: () async {
                            final authService = AuthService();
                            final userCredential =
                                await authService.signInWithGoogle();

                            if (userCredential != null) {
                              await authController.loginWithGoogle();
                              print("Logged in: ${userCredential.user!.email}");
                              print(
                                  'username : ${userCredential.user!.displayName}');
                            }
                          },
                        ),
                        _buildLoginWith(
                            title: 'Continue With Facebook',
                            imagePath: facebookImagePath,
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => RegisterScreen());
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 4,
                  offset: Offset(0, 4),
                  blurRadius: 4)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Text(
                'Login',
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[a-zA-Z ]*$')),
                        ],
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Username',
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
                            return 'Please input password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: !isVisibled,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key_sharp),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisibled = !isVisibled;
                                  });
                                },
                                // icon remove eyes name ->
                                icon: Icon(isVisibled
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined)),
                            labelText: 'Password',
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ))),
                      ),
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  Get.to(NewPasswordScreen());
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authController.login(
                            username: username, password: password);
                        print('username : $username');
                        print('password : $password');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        foregroundColor: Colors.white),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginWith(
      {required String title,
      required String imagePath,
      required Function() onPressed}) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
          ],
        ));
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 300,
          color: primaryColor,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    200,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
