import 'package:get/get.dart';
import 'package:library_management_app/services/apis/report_api.dart';
import '../models/report.dart';

enum ReportType { monthly, yearly }

class ReportController extends GetxController {
  final reportType = ReportType.monthly.obs;
  final isLoading = false.obs;
  final report = Report.empty().obs;
  final reportApi = ReportApi();

  @override
  void onInit() {
    fetchReports();
    super.onInit();
  }

  void changeType(ReportType type) {
    reportType.value = type;
    fetchReports();
  }

  Future<void> fetchReports() async {
    try {
      isLoading.value = true;
      report.value = await reportApi.getReports(
        type: reportType.value.name,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> exportReport(String format) async {
    await reportApi.exportReport(
      type: reportType.value.name,
      format: format,
    );
  }
}
