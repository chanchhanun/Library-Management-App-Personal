import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_management_app/constants/app_const.dart';
import 'package:library_management_app/constants/token_storage.dart';
import 'package:library_management_app/models/dashboard.dart';

class AdminApi {
  final baseUrl = AppConst.baseUrl;
  final _tokenStorage = TokenStorage();

  Future<Dashboard> fetchDashboardStats() async {
    try {
      final url = Uri.parse("$baseUrl/dashboard/");
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${await _tokenStorage.getToken()}",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Dashboard.fromJson(data);
      } else {
        return Dashboard.empty();
      }
    } catch (e) {
      return Dashboard.empty();
    }
  }
}
