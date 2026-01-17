import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:library_management_app/constants/app_const.dart';

import '../../models/category.dart';

class CategoryApi {
  final baseUrl = AppConst.baseUrl;

  // fetch all category
  Future<List<Category>> fetchCategory() async {
    try {
      final url = Uri.parse('$baseUrl/categories');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body)['results'];
        return data.map((e) => Category.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('error fetch category : $e');
      return [];
    }
  }
}
