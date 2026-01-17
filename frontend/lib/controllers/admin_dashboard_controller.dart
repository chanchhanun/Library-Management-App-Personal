import 'package:get/get.dart';
import 'package:library_management_app/services/apis/admin_api.dart';

class AdminDashboardController extends GetxController {
  var isLoading = false.obs;
  var totalBooks = 0.obs;
  var borrowedBooks = 0.obs;
  var overdueBooks = 0.obs;
  var totalUsers = 0.obs;
  final adminApi = AdminApi();

  @override
  void onInit() {
    fetchDashboardData();
    super.onInit();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      final data = await adminApi.fetchDashboardStats();
      totalBooks.value = data.totalBooks ?? 0;
      borrowedBooks.value = data.borrowedBooks ?? 0;
      overdueBooks.value = data.overdueBooks ?? 0;
      totalUsers.value = data.totalUsers ?? 0;
    } finally {
      isLoading.value = false;
    }
  }
}
