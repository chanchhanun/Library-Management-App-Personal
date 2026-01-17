import 'package:get/get.dart';
import 'package:library_management_app/constants/snack_bar.dart';
import 'package:library_management_app/models/borrow_history.dart';
import 'package:library_management_app/services/apis/borrow_api.dart';

import '../models/admin_borrow.dart';
import '../models/borrow.dart';

class BorrowController extends GetxController {
  final borrowApi = BorrowApi();
  final borrows = <Borrow>[].obs;
  final allBorrows = <AdminBorrow>[].obs;
  final history = <BorrowHistory>[].obs;
  final borrowDays = [7, 14, 21, 30];
  var selectedDays = 7.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchMyBorrows();
    fetchHistory();
    fetchAllBorrows();
    super.onInit();
  }

  // fetch all my borrows for admin is_staff = true
  Future<void> fetchAllBorrows() async {
    isLoading.value = true;
    final borrowList = await borrowApi.fetchAllBorrows();
    allBorrows.assignAll(borrowList);
    isLoading.value = false;
  }

  /// Confirm borrow request
  Future<void> confirmBorrow() async {
    isLoading.value = true;

    try {
      // TODO: Call Django API here
      await Future.delayed(const Duration(seconds: 2));

      SnackBar.showSnackBar(
        isError: false,
        title: "Success",
        message: "Borrow request submitted successfully",
      );
    } catch (e) {
      SnackBar.showSnackBar(
        isError: true,
        title: "Error",
        message: "Failed to submit borrow request",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // fetch my borrow
  Future<void> fetchMyBorrows() async {
    isLoading.value = true;
    final borrowList = await borrowApi.fetchMyBorrows();
    borrows.assignAll(borrowList);
    isLoading.value = false;
  }

  // fetch borrow history
  Future<void> fetchHistory() async {
    isLoading.value = true;
    final historyList = await borrowApi.fetchBorrowHistory();
    history.assignAll(historyList);
    isLoading.value = false;
  }

  // borrow book
  Future<void> borrowBook(
      {required int id,
      required int borrowDays,
      required String returnDate}) async {
    isLoading(true);
    await borrowApi.borrowBook(
        id: id, borrowDays: borrowDays, returnDate: returnDate);
    isLoading(false);
  }

  // return book
  Future<void> returnBook({required int id}) async {
    isLoading(true);
    await borrowApi.returnBook(id: id);
    isLoading(false);
  }
}
