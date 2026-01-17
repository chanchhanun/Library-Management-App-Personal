import 'package:get/get.dart';
import 'package:library_management_app/constants/snack_bar.dart';
import '../services/apis/borrow_api.dart';

class ReturnBookController extends GetxController {
  var isLoading = false.obs;
  var bookTitle = ''.obs;
  var dueDate = ''.obs;
  var fine = 0.0.obs;
  final borrowApi = BorrowApi();

  late int borrowId;

  Future<void> fetchReturnPreview(int id) async {
    borrowId = id;
    isLoading.value = true;

    try {
      final data = await borrowApi.getReturnPreview(id);
      bookTitle.value = data.bookTitle;
      dueDate.value = data.returnDate;
      fine.value = data.fine.toDouble();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> confirmReturn() async {
    try {
      isLoading.value = true;
      await borrowApi.returnBook(id: borrowId);
    } catch (_) {
      Get.snackbar("Error", "Failed to return book");
    } finally {
      isLoading.value = false;
    }
  }
}
