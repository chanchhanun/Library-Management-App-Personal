import 'package:flutter/material.dart' hide SnackBar;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:library_management_app/models/book.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/widgets/custom_button.dart';
import 'package:library_management_app/constants/snack_bar.dart';
import '../controllers/borrow_controller.dart';
import 'borrow_history_screen.dart';

class BookDetail extends StatelessWidget {
  final Book book;

  BookDetail({super.key, required this.book});
  final borrowController = Get.put(BorrowController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Book Details'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildContent()),
          _buildBorrowButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              book.image ?? '',
              width: 120,
              height: 170,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 120,
                height: 170,
                color: Colors.white,
                child: const Icon(Icons.book, size: 60),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Title & Author
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title ?? 'Unknown Title',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'by ${book.authorName ?? 'Unknown'}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                _statusBadge(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoGrid(),
          const SizedBox(height: 20),
          const Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            book.description ?? 'No description available.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _infoGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _infoCard('ISBN', book.isbn ?? 'N/A'),
        _infoCard('Published', book.publishedDate ?? 'N/A'),
        _infoCard(
          'Available',
          '${book.availableCopies ?? 0}/${book.totalCopies ?? 0}',
        ),
      ],
    );
  }

  Widget _infoCard(String title, String value) {
    return Expanded(
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge() {
    final isAvailable = (book.availableCopies ?? 0) > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isAvailable ? 'Available' : 'Unavailable',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBorrowButton() {
    final canBorrow = (book.availableCopies ?? 0) > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: CustomButton(
        title: canBorrow ? 'Borrow Book' : 'Not Available',
        onPressed: () async {
          if (canBorrow) {
            final returnDate = DateFormat('yyyy-MM-dd')
                .format(DateTime.now().add(const Duration(days: 7)));

            await borrowController.borrowBook(
              id: book.id ?? 0,
              borrowDays: borrowController.selectedDays.value,
              returnDate: returnDate,
            );
          } else {
            SnackBar.showSnackBar(
              isError: true,
              title: 'Book Not Available',
              message: 'This book is not available for borrowing.',
            );
          }
        },
      ),
    );
  }
}
