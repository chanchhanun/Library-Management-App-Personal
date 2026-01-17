import 'package:get/get.dart';

import '../models/notification.dart';
import '../services/apis/notification_api.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notifications = <Notification>[].obs;
  final notificationApi = NotificationApi();

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      notifications.value = await notificationApi.fetchNotifications();
    } finally {
      isLoading.value = false;
    }
  }
}
