import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/controllers/book_controller.dart';
import 'package:library_management_app/controllers/borrow_controller.dart';
import 'package:library_management_app/models/borrow.dart';
import '../controllers/return_book_controller.dart';
import '../models/book.dart';

class ReturnBookScreen extends StatelessWidget {
  final Borrow borrow;

  ReturnBookScreen({super.key, required this.borrow});
  final borrowController = Get.put(BorrowController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: Navigator.canPop(context)
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))
              : null,
          title: Text(
            "Return Book",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (borrowController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 4,
                          blurRadius: 4,
                        )
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Book Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          borrow.bookDetail?.image ?? '',
                          height: 100,
                          width: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                  color: Colors.grey[300],
                                  height: 100,
                                  width: 80),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Book Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              borrow.bookDetail?.title ?? '-',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Borrowed: ${borrow.borrowDate ?? '-'}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Return: ${borrow.returnDate ?? '-'}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Status: ${borrow.bookDetail?.status ?? '-'}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      await borrowController.returnBook(id: borrow.id ?? 0);
                    },
                    child: const Text("Confirm Return"),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
