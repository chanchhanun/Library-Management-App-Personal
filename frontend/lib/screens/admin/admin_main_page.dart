import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/screens/admin/manage_books_screen.dart';
import 'package:library_management_app/screens/books_screen.dart';

import '../profile_screen.dart';
import 'admin_dashboard_screen.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  var selectedIndex = 0;

  // BottomNav
  // ├── Dashboard
  // ├── Books
  // ├── Requests
  // └── Profile
  //   └── Drawer
  //       ├── Users
  //       ├── Reports
  //       ├── Categories

  final pages = [
    AdminDashboardScreen(),
    ManageBooksScreen(),
    // RequestScreen(),
    // AdminProfile(),
    ProfileScreen(
      isStaff: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.black,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              activeIcon: Icon(Iconsax.home_1),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.book_1_copy),
              activeIcon: Icon(Iconsax.book_1),
              label: 'Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
              activeIcon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ]),
    );
  }
}
