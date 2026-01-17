import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import '../controllers/notification_controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      // write without using controller
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(
                item['type'] == 'overdue'
                    ? Icons.warning_amber_rounded
                    : Icons.notifications_active,
                color: item['type'] == 'overdue' ? Colors.red : Colors.orange,
              ),
              title: Text(
                item['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['message']),
              trailing: Text(
                item['date'],
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Map<String, dynamic>> notifications = [
  {
    "id": 0,
    "title": "Book Due Tomorrow",
    "message": "Clean Code is due on 2026-01-15",
    "type": "due",
    "date": "2026-01-14"
  },
  {
    "id": 1,
    "title": "Overdue Book",
    "message": "Flutter in Action is overdue by 1 day",
    "type": "overdue",
    "date": "2026-01-13"
  },
  {
    "id": 2,
    "title": "Book Due Soon",
    "message": "Design Patterns is due on 2026-01-16",
    "type": "due",
    "date": "2026-01-14"
  },
  {
    "id": 3,
    "title": "Overdue Alert",
    "message": "Python Crash Course is overdue by 3 days",
    "type": "overdue",
    "date": "2026-01-11"
  },
  {
    "id": 4,
    "title": "Book Due Tomorrow",
    "message": "Django for APIs is due on 2026-01-15",
    "type": "due",
    "date": "2026-01-14"
  },
  {
    "id": 5,
    "title": "Overdue Book",
    "message": "Effective Java is overdue by 5 days",
    "type": "overdue",
    "date": "2026-01-09"
  },
  {
    "id": 6,
    "title": "Book Due Soon",
    "message": "Clean Architecture is due on 2026-01-17",
    "type": "due",
    "date": "2026-01-15"
  },
  {
    "id": 7,
    "title": "Overdue Alert",
    "message": "Refactoring is overdue by 2 days",
    "type": "overdue",
    "date": "2026-01-12"
  },
  {
    "id": 8,
    "title": "Book Due Tomorrow",
    "message": "You Don't Know JS is due on 2026-01-15",
    "type": "due",
    "date": "2026-01-14"
  },
  {
    "id": 9,
    "title": "Overdue Book",
    "message": "Head First Design Patterns is overdue by 4 days",
    "type": "overdue",
    "date": "2026-01-10"
  }
];

///Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.notifications.isEmpty) {
//           return const Center(
//             child: Text("No notifications 🎉"),
//           );
//         }
//
//         return ListView.builder(
//           itemCount: controller.notifications.length,
//           itemBuilder: (context, index) {
//             final item = controller.notifications[index];
//
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: ListTile(
//                 leading: Icon(
//                   item.type == 'overdue'
//                       ? Icons.warning_amber_rounded
//                       : Icons.notifications_active,
//                   color: item.type == 'overdue' ? Colors.red : Colors.orange,
//                 ),
//                 title: Text(
//                   item.title,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(item.message),
//                 trailing: Text(
//                   item.date,
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
