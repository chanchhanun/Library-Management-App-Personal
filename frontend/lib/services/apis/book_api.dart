import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:library_management_app/constants/app_const.dart';
import 'package:library_management_app/constants/snack_bar.dart';

import '../../models/book.dart';

class BookApi {
  final baseUrl = AppConst.baseUrl;

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books/'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>> getAvailableBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books/available/'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load available books');
    }
  }

  Future<void> addBook({
    required String title,
    required String isbn,
    required String category,
    required String author,
    required String status,
    required String publishedDate,
    required int totalCopies,
    required int availableCopies,
    required String description,
    required File image,
  }) async {
    final url = Uri.parse('$baseUrl/books/');
    // final response = await http.post(
    //   url,
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     "title": title,
    //     "isbn": isbn,
    //     "category": category,
    //     "author": author,
    //     "status": status,
    //     "publishedDate": publishedDate,
    //     "totalCopies": totalCopies,
    //     "availableCopies": availableCopies,
    //     "description": description,
    //     "image": image,
    //   }),
    // );
    // print('book : ${response.body}');
    // print('status : ${response.statusCode}');

    var request = http.MultipartRequest("POST", url);

    request.fields['title'] = title;
    request.fields['isbn'] = isbn;
    request.fields['category'] = category;
    request.fields['author'] = author;
    request.fields['status'] = status;
    request.fields['published_date'] = publishedDate;
    request.fields['total_copies'] = totalCopies.toString();
    request.fields['available_copies'] = availableCopies.toString();
    request.fields['description'] = description;

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: http.MediaType(
          'image',
          'jpeg',
        ), // <-- helps Django detect file
      ),
    );

    var response = await request.send();

    var body = await response.stream.bytesToString();
    print("status code : ${response.statusCode}");
    print("server response : $body");

    if (response.statusCode == 201 || response.statusCode == 200) {
      SnackBar.showSnackBar(
        isError: false,
        message: 'Add book success',
        title: 'Success',
      );
      print('add book success');
    } else {
      print('add book failed');
      SnackBar.showSnackBar(
        isError: true,
        message: 'Add book failed',
        title: 'Error',
      );
    }
  }

  Future<void> updateBook({
    required String id,
    required String title,
    required String isbn,
    required String category,
    required String author,
    required String status,
    required String publishedDate,
    required int totalCopies,
    required int availableCopies,
    required String description,
    File? image,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/books/${id}/');
      var request = http.MultipartRequest("PATCH", url);

      request.fields['title'] = title;
      request.fields['isbn'] = isbn;
      request.fields['category'] = category;
      request.fields['author'] = author;
      request.fields['status'] = status;
      request.fields['published_date'] = publishedDate;
      request.fields['total_copies'] = totalCopies.toString();
      request.fields['available_copies'] = availableCopies.toString();
      request.fields['description'] = description;

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
            contentType: http.MediaType(
              'image',
              'jpeg',
            ), // <-- helps Django detect file
          ),
        );
      }

      var response = await request.send();

      var body = await response.stream.bytesToString();
      print("status code : ${response.statusCode}");
      print("server response : $body");

      if (response.statusCode == 201 || response.statusCode == 200) {
        SnackBar.showSnackBar(
          isError: false,
          message: 'Update book success',
          title: 'Success',
        );
        print('update book success');
      } else {
        print('update book failed');
        SnackBar.showSnackBar(
          isError: true,
          message: 'Update book failed',
          title: 'Error',
        );
      }
    } catch (e) {
      print("Error updating book: $e");
    }
  }

  Future<void> deleteBook({required String id}) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/books/$id/'));
      if (response.statusCode == 204) {
        SnackBar.showSnackBar(
          isError: false,
          message: 'Delete book success',
          title: 'Success',
        );
      } else {
        SnackBar.showSnackBar(
          isError: true,
          message: 'Delete book failed',
          title: 'Error',
        );
      }
    } catch (e) {
      print("Error deleting book: $e");
    }
  }

  // fetch filter book by category id
  Future<List<Book>> filterBooksByCategoryId(
      {required String categoryId}) async {
    try {
      final url = Uri.parse('$baseUrl/books/?category=$categoryId');
      final res = await http.get(url);

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        return data.map((e) => Book.fromJson(e)).toList();
      } else {
        print('object');
        return [];
      }
    } catch (e) {
      print('error : $e');
      return [];
    }
  }
}
