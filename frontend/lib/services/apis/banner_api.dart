import 'dart:convert';

import 'package:library_management_app/constants/app_const.dart';
import 'package:http/http.dart' as http;

import '../../models/banner.dart';

class BannerApi {
  // baseUrl
  final baseUrl = AppConst.baseUrl;
  Future<List<Banner>> fetchBanners() async {
    try {
      final url = Uri.parse('$baseUrl/banners');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body)['results'];
        return data.map((e) => Banner.fromJson(e)).toList();
      } else {
        print('error banner : ${res.body}');
        print('status : ${res.statusCode}');
        return [];
      }
    } catch (e) {
      print('error banner : ${e}');
      return [];
    }
  }
}
