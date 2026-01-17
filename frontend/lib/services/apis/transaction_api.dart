import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/app_const.dart';
import '../../models/transaction.dart';

class TransactionApi {
  final baseUrl = AppConst.baseUrl;

  // Transactions
  Future<List<Transaction>> getTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/transactions/'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['results'];
      return body.map((dynamic item) => Transaction.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<Transaction>> getActiveTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/transactions/active/'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Transaction.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load active transactions');
    }
  }

  Future<Transaction> borrowBook(int bookId, int memberId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'book': bookId, 'member': memberId}),
    );
    if (response.statusCode == 201) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to borrow book');
    }
  }

  Future<Transaction> returnBook(int transactionId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions/$transactionId/return_book/'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to return book');
    }
  }
}
