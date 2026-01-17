import 'package:flutter/material.dart';
import 'package:library_management_app/constants/repository.dart';
import 'package:library_management_app/screens/book_detail.dart';
import 'package:library_management_app/widgets/custom_card.dart';

import '../constants/color_const.dart';
import 'package:get/get.dart';

import '../controllers/book_controller.dart';

class BookFilterCategory extends StatefulWidget {
  const BookFilterCategory({super.key, required this.title, required this.id});
  final String title;
  final String id;

  @override
  State<BookFilterCategory> createState() => _BookFilterCategoryState();
}

class _BookFilterCategoryState extends State<BookFilterCategory> {
  final bookController = Get.put(BookController());

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () async {
        await bookController.filterBooksByCategoryId(categoryId: widget.id);
      },
    );
    print('book filter by category : ${bookController.filterBooks}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Navigator.canPop(context)
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))
              : null,
          backgroundColor: primaryColor,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            var books = bookController.filterBooks;
            if (books.isEmpty) {
              return Center(
                child: Text('No books found'),
              );
            }
            if (bookController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  childAspectRatio: .67),
              itemCount: books.length,
              itemBuilder: (context, index) {
                var book = books[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(BookDetail(
                      book: book,
                    ));
                  },
                  child: CustomCard(
                    book: book,
                    onTap: () {
                      Get.to(BookDetail(
                        book: book,
                      ));
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
