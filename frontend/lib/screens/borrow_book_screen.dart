import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/widgets/custom_button.dart';
import '../controllers/borrow_controller.dart';

class BorrowBookScreen extends StatelessWidget {
  BorrowBookScreen({super.key});

  final BorrowController controller = Get.put(BorrowController());
  final imagePath = 'assets/technology/computer_book.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Borrow Book",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 📘 Book Info
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Image.asset(
                  imagePath,
                ),
                title: Text(
                  "Clean Code",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Author: Robert C. Martin"),
              ),
            ),
            const SizedBox(height: 24),

            /// ⏱ Borrow Duration
            const Text(
              "Select Borrow Duration",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Obx(
              () => DropdownButtonFormField<int>(
                value: controller.selectedDays.value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: controller.borrowDays
                    .map(
                      (day) => DropdownMenuItem(
                        value: day,
                        child: Text("$day days"),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  print('value : $value days');
                  controller.selectedDays.value = value!;
                },
              ),
            ),

            const SizedBox(height: 32),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.confirmBorrow,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Confirm Borrow"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
