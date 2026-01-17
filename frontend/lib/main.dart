import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/token_storage.dart';
import 'package:library_management_app/routes/route.dart';
import 'package:library_management_app/routes/route_page.dart';
import 'package:library_management_app/services/notification/notification_service.dart';

import 'controllers/auth_controller.dart';

Future<void> main() async {
  // what does this do?
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  final initialRoute = await getInitialRoute();
  await NotificationService.init();
  await NotificationService.notificationPermission();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp(initialRoute: initialRoute));
  FlutterNativeSplash.remove();
}

// void isLogined() async {
//   final tokenStorage = TokenStorage();
//   final token = await tokenStorage.getToken();
//   print('token : $token');
//   if (token != null) {
//     Get.to(HomeScreen());
//   } else {
//     Get.to(LoginScreen());
//   }
// }

// Future<String> _getInitialRoute() async {
//   final tokenStorage = TokenStorage();
//   final token = await tokenStorage.getToken();
//   final authController = Get.put(AuthController());
//   final user = authController.user.value;
//   final isStaff = user.isStaff;
//   // user info
//   print('token : $token');
//   print('user : $user');
//   print('isStaff : $isStaff');
//
//   return token != null ? Route.AdminMainPage : Route.GetStartScreen;
// }

Future<String> getInitialRoute() async {
  final tokenStorage = TokenStorage();
  final token = await tokenStorage.getToken();
  if (token == null || token.isEmpty) {
    // No token → go to GetStartScreen
    return Route.GetStartScreen;
  }
  // Initialize AuthController
  final authController = Get.put(AuthController());
  await authController.fetchSingleUser();
  final user = authController.user.value;
  final isStaff = user.isStaff;
  // Decide initial route
  return isStaff ? Route.AdminMainPage : Route.MainPage;
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      getPages: RoutePage.pages,
    );
  }
}

// echo "# Library-Management-App-Personal" >> README.md
// git init
// git add README.md
// git commit -m "first commit"
// git branch -M main
// git remote add origin https://github.com/chanchhanun/Library-Management-App-Personal.git
// git push -u origin main
// …or push an existing repository from the command line
// git remote add origin https://github.com/chanchhanun/Library-Management-App-Personal.git
// git branch -M main
// git push -u origin main
