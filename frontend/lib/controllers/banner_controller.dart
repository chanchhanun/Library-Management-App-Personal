import 'package:get/get.dart';

import '../models/banner.dart';
import '../services/apis/banner_api.dart';

class BannerController extends GetxController {
  var banners = <Banner>[].obs;
  var isLoading = false.obs;
  final bannerApi = BannerApi();

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  // fetch banner
  Future<void> fetchBanners() async {
    isLoading(true);
    final bannerList = await bannerApi.fetchBanners();
    banners.assignAll(bannerList);
    isLoading(false);
  }
}
