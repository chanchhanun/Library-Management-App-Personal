import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_management_app/services/apis/book_api.dart';

import '../models/book.dart';
import '../models/category.dart';

class BookController extends GetxController {
  final _bookApi = BookApi();
  final books = <Book>[].obs;
  var isLoading = false.obs;
  var imageFile = Rx<File?>(null);
  final filterBooks = <Book>[].obs;
  var selectedCategoryId = RxnInt();
  final categories = <Category>[].obs;
  final authors = <Author>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBooks();
  }

  // search query
  void searchBooks(String query) {
    if (query.isEmpty) {
      getBooks();
    } else {
      final filteredBooks = books.where((book) {
        return book.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      if (filteredBooks.isNotEmpty) {
        books.assignAll(filteredBooks);
      }
    }
  }

  // filtered list
  List<Book> get filteredBooks {
    if (selectedCategoryId.value == null) {
      return books;
    }
    return books.where((b) => b.category == selectedCategoryId.value).toList();
  }

  void filterByCategory(int? categoryId) {
    selectedCategoryId.value = categoryId;
  }

  // filter book by category
  // void filterBooksByCategory(String category) {
  //   if (category == 'All') {
  //     getBooks();
  //   } else {
  //     final filteredBooks = books.where((book) {
  //       // we hav't had category model in backend yet
  //       return book.author!.name == category;
  //     }).toList();
  //     print('filder books : ${filteredBooks}');
  //     books.assignAll(filteredBooks);
  //   }
  // }

  // get book
  Future<void> getBooks() async {
    isLoading(true);
    final bookList = await _bookApi.getBooks();
    books.assignAll(bookList);
    await _bookApi.getBooks();
    isLoading(false);
  }

  // get Available Books
  Future<void> getAvailableBooks() async {
    isLoading(true);
    final bookList = await _bookApi.getAvailableBooks();
    books.assignAll(bookList);
    isLoading(false);
  }

  final picker = ImagePicker();
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
    print('pick image : ${imageFile.value}');
  }

  // create book
  Future<void> addBook({required Book book}) async {
    await _bookApi.addBook(book: book);
  }

  // update book
  Future<void> updateBook({required Book book}) async {
    await _bookApi.updateBook(book: book);
  }

  // delete book
  Future<void> deleteBook({required String id}) async {
    await _bookApi.deleteBook(id: id);
  }

  // filter book by category id
  Future<void> filterBooksByCategoryId({required String categoryId}) async {
    isLoading(true);
    final bookList =
        await _bookApi.filterBooksByCategoryId(categoryId: categoryId);
    filterBooks.assignAll(bookList);
    isLoading(false);
  }

  // return book
}
