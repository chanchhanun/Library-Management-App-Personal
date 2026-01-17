import 'package:get/get.dart';

import '../models/author.dart';
import '../services/apis/author_api.dart';

class AuthorController extends GetxController {
  final _authorApi = AuthorApi();
  final authors = <Author>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAuthors();
  }

  // get authors
  Future<void> getAuthors() async {
    isLoading(true);
    final authorList = await _authorApi.getAuthors();
    authors.assignAll(authorList);
    isLoading(false);
  }

  // create author
  Future<void> createAuthor(Author author) async {
    await _authorApi.createAuthor(author);
  }
}
