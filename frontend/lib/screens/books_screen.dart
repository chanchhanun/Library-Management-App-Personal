import 'package:flutter/material.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/controllers/book_controller.dart';
import 'package:get/get.dart';
import 'package:library_management_app/controllers/category_controller.dart';
import 'package:library_management_app/screens/book_detail.dart';

class BooksScreen extends StatefulWidget {
  BooksScreen({super.key, required this.fromHome});
  bool fromHome = false;

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final bookController = Get.put(BookController());
  final categoryController = Get.put(CategoryController());
  var selectedBook = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        // if navigator push show leading if not show back button
        // if navigator from HomeScreen show back button if not show leading
        leading: widget.fromHome
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
        centerTitle: true,
        title: const Text(
          'Book List',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 12,
          children: [
            _buildSearchComponent(),
            _buildBookCategoryButtonList(),
            _buildBookCard(),
          ],
        ),
      ),
    );
  }

  // search query function
  void _searchBooks(String query) {
    bookController.searchBooks(query);
  }

  Widget _buildBookCard() {
    return Obx(() {
      if (bookController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final books = bookController.filteredBooks;
      if (books.isEmpty) {
        return SingleChildScrollView(
          child: Container(
            height: 500,
            child: Center(
              child: Text(
                'No books found',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      }
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final book = books[index];

          return GestureDetector(
            onTap: () => Get.to(() => BookDetail(
                  book: book,
                )),
            child: Container(
              height: 140,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      book.image ?? '',
                      width: 100,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.book, size: 80),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                book.title ?? 'No title',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            _availability(book.availableCopies),
                          ],
                        ),
                        Text('By ${book.authorName ?? "Unknown"}'),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                book.description ?? 'No description',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            _statusBadge(book.status),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _availability(int? copies) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.red.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text('${copies ?? 0} Available'),
    );
  }

  Widget _statusBadge(String? status) {
    final text = status == null
        ? 'Unknown'
        : status[0].toUpperCase() + status.substring(1).toLowerCase();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBookCategoryButtonList() {
    return Obx(() {
      final categories = categoryController.categories;

      if (categories.isEmpty) {
        return const Center(child: Text('No categories found'));
      }

      return SizedBox(
        height: 50,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length + 1,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            // ✅ ALL button
            if (index == 0) {
              final isSelected =
                  bookController.selectedCategoryId.value == null;

              return _categoryButton(
                title: 'All',
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    selectedBook = 'All';
                  });
                  bookController.filterByCategory(null);
                },
              );
            }

            // ✅ Category buttons
            final category = categories[index - 1];
            final isSelected =
                bookController.selectedCategoryId.value == category.id;

            return _categoryButton(
              title: category.name ?? '',
              isSelected: isSelected,
              onTap: () {
                bookController.filterByCategory(category.id);
                setState(() {
                  selectedBook = category.name ?? '';
                });
              },
            );
          },
        ),
      );
    });
  }

  Widget _categoryButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : primaryColor,
        foregroundColor: isSelected ? primaryColor : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSearchComponent() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        onChanged: _searchBooks,
        decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(12)),
      ),
    );
  }
}
