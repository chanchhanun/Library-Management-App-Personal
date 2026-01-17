import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/controllers/admin_dashboard_controller.dart';
import 'package:library_management_app/controllers/author_controller.dart';
import 'package:library_management_app/controllers/book_controller.dart';
import 'package:library_management_app/controllers/borrow_controller.dart';

import '../../controllers/auth_controller.dart';

class AdminDashboardScreen extends StatelessWidget {
  AdminDashboardScreen({super.key});

  final bookController = Get.put(BookController());
  final borrowController = Get.put(BorrowController());
  final authController = Get.put(AuthController());
  final authorController = Get.put(AuthorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (bookController.isLoading.value ||
            borrowController.isLoading.value ||
            authController.isLoading.value ||
            authorController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _StatCard(
                title: "Total Books",
                value: bookController.books.length,
                icon: Icons.menu_book,
                color: Colors.blue,
              ),
              _StatCard(
                title: "Borrowed Books",
                value: borrowController.allBorrows.length,
                icon: Icons.bookmark,
                color: Colors.orange,
              ),
              _StatCard(
                title: "Total Authors",
                value: authorController.authors.length,
                icon: Icons.person,
                color: Colors.red,
              ),
              _StatCard(
                title: "Total Users",
                value: authController.users.length,
                icon: Icons.people,
                color: Colors.green,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}
