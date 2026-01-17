import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_management_app/constants/app_const.dart';
import 'package:library_management_app/constants/snack_bar.dart';

import '../../constants/token_storage.dart';
import '../../models/notification.dart';

class NotificationApi {
  final baseUrl = AppConst.baseUrl;
  final _storageToken = TokenStorage();

  Future<List<Notification>> fetchNotifications() async {
    try {
      final url = Uri.parse("$baseUrl/notifications/");
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${await _storageToken.getToken()}",
        },
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data = jsonDecode(response.body);
        SnackBar.showSnackBar(
          isError: false,
          title: "Success",
          message: "Fetch notifications successfully",
        );
        return data.map((e) => Notification.fromJson(e)).toList();
      } else {
        print("Error fetching notifications: ${response.statusCode}");
        SnackBar.showSnackBar(
          isError: true,
          title: "Error",
          message: "Fetch notifications failed",
        );
        return [];
      }
    } catch (e) {
      print("Error fetching notifications: $e");
      return [];
    }
  }
}
