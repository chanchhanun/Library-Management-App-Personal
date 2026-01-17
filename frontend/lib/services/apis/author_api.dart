import 'dart:convert';

import '../../constants/app_const.dart';
import '../../constants/token_storage.dart';
import '../../models/author.dart';
import 'package:http/http.dart' as http;

class AuthorApi {
  final baseUrl = AppConst.baseUrl;
  final _storageToken = TokenStorage();

  // Authors
  Future<List<Author>> getAuthors() async {
    final url = Uri.parse('$baseUrl/authors/');
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Token ${await _storageToken.getToken()}'
    });
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['results'];

      return body.map((dynamic item) => Author.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load authors');
    }
  }

  Future<Author> createAuthor(Author author) async {
    final response = await http.post(
      Uri.parse('$baseUrl/authors/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(author.toJson()),
    );
    if (response.statusCode == 201) {
      return Author.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create author');
    }
  }
}
