import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:library_management_app/constants/app_const.dart';
import 'package:library_management_app/constants/snack_bar.dart';
import 'package:library_management_app/models/borrow.dart';
import 'package:library_management_app/models/borrow_history.dart';
import 'package:library_management_app/models/return.dart';

import '../../constants/token_storage.dart';
import '../../models/admin_borrow.dart';

class BorrowApi {
  final baseUrl = AppConst.baseUrl;
  final _storageToken = TokenStorage();

  // fetch all my borrows for admin is_staff = true
  Future<List<AdminBorrow>> fetchAllBorrows() async {
    try {
      final url = Uri.parse('$baseUrl/all-borrows/');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Token ${await _storageToken.getToken()}'
        },
      );
      // token
      print('token : ${await _storageToken.getToken()}');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print('fetchAllBorrows : $data');
        return data.map((e) => AdminBorrow.fromJson(e)).toList();
      } else {
        print('else error : ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('error : $e');
      return [];
    }
  }

  Future<List<Borrow>> fetchMyBorrows() async {
    try {
      final url = Uri.parse('$baseUrl/borrows/');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Token ${await _storageToken.getToken()}'
        },
      );
      print('status : ${response.statusCode}');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print('fetchMyBorrows : $data');
        return data.map((e) => Borrow.fromJson(e)).toList();
      } else {
        print('fetchMyBorrows status: ${response.statusCode}');
        // print('body : ${response.body}');
        return [];
      }
    } catch (e) {
      print('error : $e');
      return [];
    }
  }

  Future<List<BorrowHistory>> fetchBorrowHistory() async {
    try {
      final url = Uri.parse("$baseUrl/borrow_history/");
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Token ${await _storageToken.getToken()}'
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        print('fetchBorrowHistory : $data');
        return data.map((e) => BorrowHistory.fromJson(e)).toList();
      } else {
        print('fetchBorrowHistory status: ${response.statusCode}');
        // print('body : ${response.body}');
        SnackBar.showSnackBar(
          isError: true,
          title: 'Error',
          message: 'Something went wrong(borrow book)',
        );
        return [];
      }
    } catch (e) {
      print('error : $e');
      SnackBar.showSnackBar(
        isError: true,
        title: 'Error',
        message: 'Something went wrong',
      );
      return [];
    }
  }

  Future<Return> getReturnPreview(int id) async {
    try {
      final url = Uri.parse("$baseUrl/borrow/$id/return-preview/");
      final res = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Token ${await _storageToken.getToken()}'
        },
      );
      if (res.statusCode == 200) {
        SnackBar.showSnackBar(
          isError: false,
          title: 'Success',
          message: 'Preview returned successfully',
        );
        return jsonDecode(res.body);
      } else {
        SnackBar.showSnackBar(
          isError: true,
          title: 'Error',
          message: 'Something went wrong(return book)',
        );
        print('getReturnPreview status: ${res.statusCode}');
        return Return.empty();
      }
    } catch (e) {
      print('error : $e');
      return Return.empty();
    }
  }

  Future<void> returnBook({required int id}) async {
    try {
      final url = Uri.parse("$baseUrl/borrows/$id/return_book/");
      final res = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Token ${await _storageToken.getToken()}'
        },
      );
      if (res.statusCode == 201 || res.statusCode == 200) {
        Get.back();
        print('return book success');
        SnackBar.showSnackBar(
          isError: false,
          title: 'Success',
          message: 'Book returned successfully',
        );
      } else {
        print('status : ${res.statusCode}');
        print('return book failed');
        SnackBar.showSnackBar(
          isError: true,
          title: 'Error',
          message: 'Something went wrong(return book)',
        );
      }
    } catch (e) {
      print('error : $e');
    }
  }

  Future<void> borrowBook(
      {required int id,
      required int borrowDays,
      required String returnDate}) async {
    try {
      final url = Uri.parse('$baseUrl/borrows/');
      final res = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Token ${await _storageToken.getToken()}'
        },
        body: jsonEncode(
          {"book": id, "borrow_days": borrowDays, "return_date": returnDate},
        ),
      );
      print('token : ${await _storageToken.getToken()}');
      final error = jsonDecode(res.body)['error'];
      if (res.statusCode == 201) {
        SnackBar.showSnackBar(
          isError: false,
          title: 'Success',
          message: 'Book borrowed successfully',
        );
        print('borrow book success');
      } else {
        SnackBar.showSnackBar(
          isError: true,
          title: 'Error',
          message: '$error',
        );
        print('body : ${res.body}');
        print('borrow book failed');
      }
    } catch (e) {
      print('error : $e');
    }
  }
}
