import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/screens/books_screen.dart';
import 'package:library_management_app/screens/my_borrowed_books_screen.dart';
import 'package:library_management_app/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:library_management_app/screens/transactions_screen.dart';
import 'home_screen.dart';
import 'members_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var selectedIndex = 0;

  final pages = [
    HomeScreen(),
    BooksScreen(
      fromHome: false,
    ),
    MyBorrowedBooksScreen(),
    // MembersScreen(),
    // TransactionsScreen(),
    ProfileScreen(),
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
              icon: Icon(Iconsax.home), // outline home
              activeIcon: Icon(Iconsax.home_1), // filled on active
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.search_favorite), // outline search
              activeIcon: Icon(Iconsax.search_normal),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.book_1_copy), // outline book
              activeIcon: Icon(Iconsax.book_1),
              label: 'My Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.user), // outline user
              activeIcon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ]),
    );
  }
}
