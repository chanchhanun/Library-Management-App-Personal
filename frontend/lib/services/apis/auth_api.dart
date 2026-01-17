import 'dart:convert';
import 'dart:developer' as dev;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:library_management_app/constants/snack_bar.dart';
import 'package:library_management_app/models/user.dart';
import 'package:library_management_app/screens/login_screen.dart';
import 'package:library_management_app/screens/main_page.dart';

import '../../constants/app_const.dart';
import '../../constants/token_storage.dart';
import '../../routes/route.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApi {
  final baseUrl = AppConst.baseUrl;
  final _storageToken = TokenStorage();

  // get all user for admin isStaff = true
  Future<List<User>> fetchAllUser() async {
    try {
      final url = Uri.parse('$baseUrl/users/');
      final res = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${await _storageToken.getToken()}',
      });
      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);
        print('data : $data');
        return data.map((e) => User.fromJson(e)).toList();
      } else {
        dev.log('else error : ${res.statusCode}');
        return [];
      }
    } catch (e) {
      dev.log('error fetch all user : $e');
      return [];
    }
  }

  // login
  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/login/');
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final body = jsonDecode(res.body);

        final token = body['token'];
        await _storageToken.setToken(token);
        final user = await fetchSingleUser();
        final initialRoute =
            user.isStaff ? Route.AdminMainPage : Route.MainPage;

        Get.offAllNamed(initialRoute);

        dev.log('success');
        SnackBar.showSnackBar(
          isError: false,
          title: 'Success',
          message: 'Login Successfully',
        );
      } else {
        dev.log('else error : ${res.statusCode}');
        dev.log('error : ${res.body}');
        SnackBar.showSnackBar(
          isError: true,
          title: 'Error',
          message: 'Login Failed',
        );
      }
    } catch (e) {
      dev.log('error auth api : $e');
      SnackBar.showSnackBar(
        isError: true,
        title: 'Error',
        message: 'Login Failed',
      );
    }
  }

  // register
  Future<void> register(
      {required String username,
      required String password,
      required String email}) async {
    try {
      final url = Uri.parse('$baseUrl/register/');
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {"username": username, "password": password, "email": email}),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.off(MainPage());
        dev.log('success');
        SnackBar.showSnackBar(
            isError: false, title: 'Success', message: 'Register Successfully');
        final token = jsonDecode(res.body)['token'];
        await _storageToken.setToken(token);
        // print('token : $token');
      } else {
        dev.log('else error : ${res.statusCode}');
        dev.log('error : ${res.body}');
        SnackBar.showSnackBar(
            isError: true, title: 'Error', message: 'Register Failed');
      }
    } catch (e) {
      dev.log('error auth api : $e');
    }
  }

  // logout
  Future<void> logout() async {
    await _storageToken.clearToken();
    Get.off(LoginScreen());
    final token = await _storageToken.getToken();
    print('token : $token');
    SnackBar.showSnackBar(
        isError: false, title: 'Success', message: 'Logout Successfully');
  }

  // fetch single user
  Future<User> fetchSingleUser() async {
    try {
      final url = Uri.parse('${baseUrl}/profile/');
      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${await _storageToken.getToken()}'
        },
      );
      if (res.statusCode == 200) {
        final user = jsonDecode(res.body);
        print('user : $user');
        return User.fromJson(user);
      } else {
        dev.log('else error : ${res.statusCode}');
        return User.empty();
      }
    } catch (e) {
      dev.log('error fetch single user : $e');
      return User.empty();
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  Future<String?> getGoogleIdToken() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account == null) return null;

    final GoogleSignInAuthentication auth = await account.authentication;

    return auth.idToken; // 👈 THIS is what Django needs
  }

  // login with google
  Future<void> loginWithGoogle({required}) async {
    final idToken = await getGoogleIdToken();
    final url = Uri.parse('$baseUrl/api/auth/google/');
    if (idToken == null) return;

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "id_token": idToken,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print("Access Token: ${data['access']}");
      print("Refresh Token: ${data['refresh']}");
      print("Email: ${data['email']}");
      print("Name: ${data['name']}");
    } else {
      print("Login failed: ${response.body}");
      print('status : ${response.statusCode}');
    }
  }
}
