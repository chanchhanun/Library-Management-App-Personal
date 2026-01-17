import 'package:get/get.dart';
import 'package:library_management_app/main.dart';
import 'package:library_management_app/models/user.dart';
import 'dart:developer' as dev;

import '../constants/token_storage.dart';
import '../services/apis/auth_api.dart';

class AuthController extends GetxController {
  final _authApi = AuthApi();
  final user = User().obs;
  var isLoading = false.obs;
  final _storageToken = TokenStorage();
  String? token;
  final users = <User>[].obs;

  @override
  void onInit() {
    fetchAllUser();
    fetchSingleUser();
    super.onInit();
  }

  // get all user for admin isStaff = true
  Future<void> fetchAllUser() async {
    isLoading(true);
    final userList = await _authApi.fetchAllUser();
    users.assignAll(userList);
    isLoading(false);
  }

  // login
  Future<void> login(
      {required String username, required String password}) async {
    try {
      await _authApi.login(username: username, password: password);
      if (token != null) {
        await _storageToken.setToken(token!);

        // ✅ Immediately fetch user info
        await fetchSingleUser();

        // Now navigation can happen safely
        final initialRoute = await getInitialRoute();
        Get.offAllNamed(initialRoute);
      }
    } catch (e) {
      dev.log('error login auth controller : $e');
    }
  }

  // register
  Future<void> register(
      {required String username,
      required String password,
      required String email}) async {
    try {
      await _authApi.register(
          username: username, password: password, email: email);
    } catch (e) {
      dev.log('error register auth controller : $e');
    }
  }

  // logout
  Future<void> logout() async {
    await _authApi.logout();
  }

  // fetch single user
  Future<void> fetchSingleUser() async {
    isLoading(true);
    final userData = await _authApi.fetchSingleUser();
    user.value = userData;
    isLoading(false);
    print('user value : ${user.value}');
  }

  // login with google
  Future<void> loginWithGoogle() async {
    await _authApi.loginWithGoogle();
  }
}
