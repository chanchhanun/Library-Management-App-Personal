import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/controllers/admin_borrowed_book_screen.dart';
import '../controllers/auth_controller.dart';
import 'admin/categories_screen.dart';
import 'admin/report_screen.dart';
import 'admin/user_list_screen.dart';
import 'borrow_history_screen.dart';
import 'my_borrowed_books_screen.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatefulWidget {
  bool isStaff;
  ProfileScreen({super.key, this.isStaff = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    authController.fetchSingleUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer
      appBar: AppBar(
        // drawer icon name ->
        leading: widget.isStaff
            ? Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )
            : null,
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      drawer: widget.isStaff
          ? Drawer(
              backgroundColor: Colors.white, // lighter background looks modern
              child: Obx(
                () {
                  if (authController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final user = authController.user.value;
                  final username = user.username ?? "Unknown User";
                  final email = user.email ?? "";
                  final firstLetter =
                      username.isNotEmpty ? username[0].toUpperCase() : "?";
                  return Column(
                    children: [
                      // Drawer Header with profile
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: primaryColor, // use your theme color
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        accountName: Text(
                          username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        accountEmail: Text(
                          email,
                          style: TextStyle(color: Colors.white),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundColor: primaryColor,
                          child: Text(
                            firstLetter,
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),

                      // Drawer menu items
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.people,
                                  color: Colors.black54),
                              title: const Text('Users'),
                              onTap: () {
                                Get.to(() => UserListScreen());
                              },
                            ),
                            // ListTile(
                            //   leading: const Icon(Icons.report,
                            //       color: Colors.black54),
                            //   title: const Text('Reports'),
                            //   onTap: () {
                            //     Get.to(() => const ReportScreen());
                            //   },
                            // ),
                            ListTile(
                              leading: const Icon(Icons.category,
                                  color: Colors.black54),
                              title: const Text('Categories'),
                              onTap: () {
                                Get.to(() => CategoriesScreen());
                              },
                            ),
                            ListTile(
                              leading:
                                  const Icon(Icons.book, color: Colors.black54),
                              title: const Text('Borrowed Books'),
                              onTap: () {
                                Get.to(() => AdminBorrowedBookScreen());
                              },
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.logout,
                                  color: Colors.redAccent),
                              title: const Text('Logout',
                                  style: TextStyle(color: Colors.redAccent)),
                              onTap: () async {
                                // Logout function
                                await authController.logout();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          : null,

      body: Obx(() {
        if (authController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = authController.user.value;
        final username = user.username ?? "Unknown User";
        final email = user.email ?? "";
        final firstLetter =
            username.isNotEmpty ? username[0].toUpperCase() : "?";
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .3,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Text(
                        firstLetter,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF007AFF),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// 📋 Menu
              !widget.isStaff
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _ProfileTile(
                            icon: Icons.book,
                            title: "My Borrowed Books",
                            onTap: () {
                              Get.to(() => MyBorrowedBooksScreen());
                            },
                          ),
                          _ProfileTile(
                            icon: Icons.history,
                            title: "Borrow History",
                            onTap: () {
                              Get.to(() => BorrowHistoryScreen());
                            },
                          ),
                          // notification
                          _ProfileTile(
                            icon: Icons.notifications,
                            title: "Notifications",
                            onTap: () {
                              Get.to(() => NotificationsScreen());
                            },
                          ),
                          _ProfileTile(
                            icon: Icons.logout,
                            title: "Logout",
                            textColor: Colors.red,
                            iconColor: Colors.red,
                            onTap: () async {
                              await authController.logout();
                            },
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _ProfileTile(
                            icon: Icons.book,
                            title: "Manage Books",
                            onTap: () {
                              // Get.to(() => AdminBookListScreen());
                            },
                          ),
                          _ProfileTile(
                            icon: Icons.category,
                            title: "Manage Categories",
                            onTap: () {
                              Get.to(() => CategoriesScreen());
                            },
                          ),
                          _ProfileTile(
                            icon: Icons.people,
                            title: "Manage Users",
                            onTap: () {
                              Get.to(() => UserListScreen());
                            },
                          ),
                          _ProfileTile(
                            icon: Icons.assignment,
                            title: "Borrow Requests",
                            onTap: () {
                              Get.to(() => AdminBorrowedBookScreen());
                            },
                          ),
                          _ProfileTile(
                            icon: Icons.bar_chart,
                            title: "Reports",
                            onTap: () {
                              Get.to(() => ReportScreen());
                            },
                          ),
                          _ProfileTile(
                            icon: Icons.logout,
                            title: "Logout",
                            textColor: Colors.red,
                            iconColor: Colors.red,
                            onTap: () async {
                              await authController.logout();
                            },
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}

/// 🔹 Reusable Tile Widget
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.blue),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor ?? Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
