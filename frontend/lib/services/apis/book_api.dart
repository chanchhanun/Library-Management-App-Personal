import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:library_management_app/constants/app_const.dart';

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

  Future<void> addBook({required Book book}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/books/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(book.toJson()),
    );
    print('book : ${response.body}');
    print('status : ${response.statusCode}');

    if (response.statusCode == 201) {
      print('add book success');
    } else {
      print('add book failed');
    }
  }

  Future<void> updateBook({required Book book}) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl${book.id}/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(book.toJson()),
      );
      if (response.statusCode == 200) getBooks();
    } catch (e) {
      print("Error updating book: $e");
    }
  }

  Future<void> deleteBook({required String id}) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$id/'));
      if (response.statusCode == 204) getBooks();
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
