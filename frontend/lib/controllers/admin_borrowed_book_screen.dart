import 'package:flutter/material.dart';
import '../constants/color_const.dart';
import 'borrow_controller.dart';
import 'package:get/get.dart';

class AdminBorrowedBookScreen extends StatefulWidget {
  AdminBorrowedBookScreen({super.key});

  @override
  State<AdminBorrowedBookScreen> createState() =>
      _AdminBorrowedBookScreenState();
}

class _AdminBorrowedBookScreenState extends State<AdminBorrowedBookScreen> {
  final borrowController = Get.put(BorrowController());

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () async {
        await borrowController.fetchAllBorrows();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Admin Borrowed Books'),
      ),
      body: Obx(() {
        if (borrowController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (borrowController.allBorrows.isEmpty) {
          return const Center(
            child: Text(
              'No borrowed books',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: borrowController.allBorrows.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final borrow = borrowController.allBorrows[index];
            final book = borrow.book!;
            final user = borrow.user!;

            final isReturned = borrow.returnDate != null;

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Book Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: book.image != null && book.image!.isNotEmpty
                          ? Image.network(
                              book.image!,
                              width: 60,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 60,
                              height: 80,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.book),
                            ),
                    ),

                    const SizedBox(width: 12),

                    /// Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Borrowed by: ${user.username}'),
                          const SizedBox(height: 4),
                          Text('Borrow date: ${borrow.borrowDate}'),
                          Text(
                            isReturned
                                ? 'Returned: ${borrow.returnDate}'
                                : 'Days: ${borrow.borrowDays}',
                          ),
                        ],
                      ),
                    ),

                    /// Status Chip
                    Chip(
                      label: Text(
                        isReturned ? 'Returned' : 'Borrowed',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor:
                          isReturned ? Colors.green : Colors.orange,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
