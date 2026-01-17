import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';

import '../../controllers/auth_controller.dart';

class UserListScreen extends StatefulWidget {
  UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () async {
        await authController.fetchAllUser();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (authController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (authController.users.isEmpty) {
          return const Center(
            child: Text(
              'No users found',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        var users = authController.users;

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: users.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final user = users[index];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      user.isStaff ? Colors.redAccent : Colors.blue,
                  child: Text(
                    user.username![0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  user.username ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(user.email ?? ''),
                trailing: Chip(
                  label: Text(
                    user.isStaff ? 'Admin' : 'User',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor:
                      user.isStaff ? Colors.redAccent : Colors.green,
                ),
                onTap: () {
                  // optional: user detail / edit
                },
              ),
            );
          },
        );
      }),
    );
  }
}
