import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_management_app/constants/app_const.dart';
import 'package:library_management_app/models/report.dart';

class ReportApi {
  final baseUrl = AppConst.baseUrl;

  Future<Report> getReports({required String type}) async {
    final res = await http.get(Uri.parse("$baseUrl/reports/?type=$type"));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return Report.fromJson(data);
    } else {
      return Report.empty();
    }
  }

  Future<void> exportReport(
      {required String type, required String format}) async {
    final url = "$baseUrl/reports/export/?type=$type&format=$format";
    // /reports/export/?type=pdf&format=monthly
    // open in browser or download via url_launcher
  }
}
