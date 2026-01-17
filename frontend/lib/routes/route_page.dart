import 'package:get/get.dart';
import 'package:library_management_app/routes/route.dart';
import 'package:library_management_app/screens/auth_screen.dart';
import 'package:library_management_app/screens/new_password_screen.dart';

import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/admin/admin_main_page.dart';
import '../screens/book_detail.dart';
import '../screens/borrow_book_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_page.dart';
import '../screens/my_borrowed_books_screen.dart';
import '../screens/password_reseted.dart';
import '../screens/profile_screen.dart';
import '../screens/get_start_screen.dart';
import '../screens/register_screen.dart';
import '../screens/welcome_screen.dart';

class RoutePage {
  static final pages = [
    GetPage(
      name: Route.HomeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Route.LoginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Route.AuthScreen,
      page: () => AuthScreen(),
    ),
    GetPage(
      name: Route.MainPage,
      page: () => MainPage(),
    ),
    GetPage(
      name: Route.ProfileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: Route.GetStartScreen,
      page: () => GetStartScreen(),
    ),
    GetPage(
      name: Route.WelcomeScreen,
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: Route.ForgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: Route.RegisterScreen,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: Route.NewPasswordScreen,
      page: () => NewPasswordScreen(),
    ),
    GetPage(
      name: Route.PasswordReseted,
      page: () => PasswordReseted(),
    ),
    GetPage(
      name: Route.BorrowBookScreen,
      page: () => BorrowBookScreen(),
    ),
    GetPage(
      name: Route.MyBorrowedBooksScreen,
      page: () => MyBorrowedBooksScreen(),
    ),
    GetPage(
      name: Route.AdminDashboardScreen,
      page: () => AdminDashboardScreen(),
    ),
    GetPage(
      name: Route.AdminMainPage,
      page: () => AdminMainPage(),
    ),
  ];
}
