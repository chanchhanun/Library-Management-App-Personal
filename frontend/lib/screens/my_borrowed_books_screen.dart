import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/screens/return_book_screen.dart';
import '../controllers/borrow_controller.dart';
import '../constants/repository.dart';

class MyBorrowedBooksScreen extends StatefulWidget {
  MyBorrowedBooksScreen({super.key});

  @override
  State<MyBorrowedBooksScreen> createState() => _MyBorrowedBooksScreenState();
}

class _MyBorrowedBooksScreenState extends State<MyBorrowedBooksScreen> {
  final controller = Get.put(BorrowController());
  bool isReturn = false;

  @override
  void initState() {
    super.initState();
    controller.fetchMyBorrows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              )
            : null,
        centerTitle: true,
        title: const Text(
          "My Borrowed Books",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          _buildBorrowedBook(),
        ],
      ),
    );
  }

  Widget _buildBorrowedBook() {
    return Obx(
      () {
        var borrows = controller.borrows;
        if (controller.isLoading.value) {
          return CircularProgressIndicator();
        }
        if (borrows.isEmpty) {
          return Expanded(
            child: Center(
              child: Text('No borrowed books'),
            ),
          );
        }
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.fetchMyBorrows();
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: borrows.length,
              itemBuilder: (context, index) {
                var borrow = borrows[index];
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
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
                        const SizedBox(width: 12),
                        // Return Button
                        TextButton(
                          onPressed: () {
                            Get.to(ReturnBookScreen(
                              borrow: borrow,
                            ));
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          child: const Text('Return'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
