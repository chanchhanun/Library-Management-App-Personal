import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/controllers/author_controller.dart';
import 'package:library_management_app/controllers/category_controller.dart';
import '../../controllers/book_controller.dart';
import '../../models/book.dart';
import 'package:image_picker/image_picker.dart';

class ManageBooksScreen extends StatefulWidget {
  ManageBooksScreen({super.key});

  @override
  State<ManageBooksScreen> createState() => _ManageBooksScreenState();
}

class _ManageBooksScreenState extends State<ManageBooksScreen> {
  final BookController bookController = Get.put(BookController());
  final categoryController = Get.put(CategoryController());
  final authorController = Get.put(AuthorController());
  int? _selectedAuthorId;
  int? _selectedCategoryId;
  String _status = 'rent';

  final _titleController = TextEditingController();
  final _isbnController = TextEditingController();
  final _publishedDateController = TextEditingController();
  final _totalCopiesController = TextEditingController();
  final _availableCopiesController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bookController.getBooks();
  }

  void _openBookSheet({Book? book}) {
    // !=null for add book
    if (book != null) {
      _titleController.text = book.title ?? '';
      _isbnController.text = book.isbn ?? '';
      _publishedDateController.text = book.publishedDate ?? '';
      _totalCopiesController.text = book.totalCopies.toString();
      _availableCopiesController.text = book.availableCopies.toString();
      _descController.text = book.description ?? '';

      _selectedAuthorId = book.authorDetail?.id;
      _selectedCategoryId = book.category;
      _status = book.status ?? 'rent';
    } else {
      // == null for edit book
      _titleController.clear();
      _isbnController.clear();
      _publishedDateController.clear();
      _totalCopiesController.clear();
      _availableCopiesController.clear();
      _descController.clear();

      _selectedAuthorId = null;
      _selectedCategoryId = null;
      _status = 'rent';

      // bookController.imageFile.value = null; // ✅ IMPORTANT
    }

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// drag handle
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Text(
                book == null ? 'Add New Book' : 'Edit Book',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              _buildTextField(
                controller: _titleController,
                label: 'Book Title',
                icon: Icons.book,
              ),

              _buildTextField(
                controller: _isbnController,
                label: 'ISBN',
                icon: Icons.qr_code,
              ),

              /// Category Dropdown
              Obx(() {
                final ids =
                    categoryController.categories.map((e) => e.id).toList();

                return DropdownButtonFormField<int>(
                  value: ids.contains(_selectedCategoryId)
                      ? _selectedCategoryId
                      : null,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: categoryController.categories
                      .map((c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.name ?? ''),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedCategoryId = val),
                );
              }),

              /// Author Dropdown
              Obx(() {
                final ids = authorController.authors.map((e) => e.id).toList();

                return DropdownButtonFormField<int>(
                  value: ids.contains(_selectedAuthorId)
                      ? _selectedAuthorId
                      : null,
                  decoration: const InputDecoration(labelText: 'Author'),
                  items: authorController.authors.map((a) {
                    return DropdownMenuItem(
                      value: a.id,
                      child: Text(a.name ?? ''),
                    );
                  }).toList(),
                  onChanged: (val) => _selectedAuthorId = val,
                );
              }),
              // Obx(() {
              //   final ids = authorController.authors.map((e) => e.id).toList();
              //
              //   return DropdownButtonFormField<int>(
              //     value: ids.contains(_selectedAuthorId)
              //         ? _selectedAuthorId
              //         : null,
              //     decoration: const InputDecoration(labelText: 'Author'),
              //     items: authorController.authors
              //         .map((a) => DropdownMenuItem(
              //               value: a.id,
              //               child: Text(a.name ?? ''),
              //             ))
              //         .toList(),
              //     onChanged: (val) => setState(() => _selectedAuthorId = val),
              //   );
              // }),

              /// Status
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'rent', child: Text('Rent')),
                  // DropdownMenuItem(
                  //     value: 'available', child: Text('Available')),
                ],
                onChanged: (val) => _status = val!,
              ),

              _buildTextField(
                controller: _publishedDateController,
                label: 'Published Date',
                icon: Icons.calendar_today,
                hint: 'YYYY-MM-DD',
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    _publishedDateController.text =
                        date.toIso8601String().split('T')[0];
                  }
                },
              ),

              _buildTextField(
                controller: _totalCopiesController,
                label: 'Total Copies',
                icon: Icons.library_books,
                keyboardType: TextInputType.number,
              ),

              _buildTextField(
                controller: _availableCopiesController,
                label: 'Available Copies',
                icon: Icons.inventory,
                keyboardType: TextInputType.number,
              ),

              _buildTextField(
                controller: _descController,
                label: 'Description',
                icon: Icons.description,
                maxLines: 2,
              ),
              // how to make this image correct logic ?
              // bookController.imageFile.value != null
              //     ? Image.file(bookController.imageFile.value!,
              //         width: double.infinity, height: 300)
              //     : Center(child: Text('No image.')),
              _buildImagePreview(book),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                child: TextButton(
                    onPressed: () async {
                      await bookController.pickImage();
                    },
                    child: const Text('Pick Image')),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    book == null
                        ? await bookController.addBook(
                            title: _titleController.text,
                            isbn: _isbnController.text,
                            category: _selectedCategoryId.toString(),
                            author: _selectedAuthorId.toString(),
                            status: _status,
                            publishedDate: _publishedDateController.text,
                            totalCopies: int.parse(_totalCopiesController.text),
                            availableCopies:
                                int.parse(_availableCopiesController.text),
                            description: _descController.text,
                            image: bookController.imageFile.value!,
                          )
                        : await bookController.updateBook(
                            id: book.id.toString(),
                            title: _titleController.text,
                            isbn: _isbnController.text,
                            category: _selectedCategoryId.toString(),
                            author: _selectedAuthorId.toString(),
                            status: _status,
                            publishedDate: _publishedDateController.text,
                            totalCopies: int.parse(_totalCopiesController.text),
                            availableCopies:
                                int.parse(_availableCopiesController.text),
                            description: _descController.text,
                            image: bookController
                                .imageFile.value!, // ❌ crash if null
                          );
                    print('title : ${_titleController.text}');
                    print('isbn : ${_isbnController.text}');
                    print('category : ${_selectedCategoryId}');
                    print('author : ${_selectedAuthorId}');
                    print('status : ${_status}');
                    print('publishedDate : ${_publishedDateController.text}');
                    print('totalCopies : ${_totalCopiesController.text}');
                    print(
                        'availableCopies : ${_availableCopiesController.text}');
                    print('description : ${_descController.text}');
                    print('image : ${bookController.imageFile.value}');
                    print(
                        'image path : ${bookController.imageFile.value?.path}');

                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save Book',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Books'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (bookController.books.isEmpty) {
          return const Center(child: Text('No books available'));
        }

        if (bookController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: bookController.books.length,
          itemBuilder: (context, index) {
            final book = bookController.books[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300),
                ],
              ),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Cover
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: book.image != null && book.image!.isNotEmpty
                        ? Image.network(
                            book.image!,
                            width: 80,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 80,
                            height: 120,
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.menu_book,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                  ),

                  const SizedBox(width: 12),

                  // Book Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title ?? 'Unknown Title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Author: ${book.authorName ?? '-'}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Published: ${book.publishedDate ?? '-'}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Actions
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        tooltip: 'Edit Book',
                        onPressed: () {
                          _openBookSheet(book: book);
                          print('author : ${bookController.authors}');
                          print('category : ${bookController.categories}');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Delete Book',
                        onPressed: () {
                          deleteConsideration(book.id.toString());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Book'),
        onPressed: () => _openBookSheet(),
      ),
    );
  }

  void deleteConsideration(String id) {
    Get.defaultDialog(
      title: 'Delete Confirmation',
      middleText: 'Are you sure you want to delete this book?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.grey,
      onConfirm: () async {
        await bookController.deleteBook(id: id);
        Navigator.pop(context);
      },
      onCancel: () => Get.back(),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    VoidCallback? onTap,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: IconButton(onPressed: onTap, icon: Icon(icon)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview(Book? book) {
    return bookController.imageFile.value != null
        ? Image.file(
            bookController.imageFile.value!,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          )
        : (book?.image?.isNotEmpty ?? false)
            ? Image.network(
                book!.image!,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              )
            : const Center(child: Text('No image selected'));
  }
}
