import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import 'package:library_management_app/controllers/auth_controller.dart';
import 'package:library_management_app/controllers/banner_controller.dart';
import 'package:library_management_app/controllers/book_controller.dart';
import 'package:library_management_app/controllers/category_controller.dart';
import 'package:library_management_app/screens/book_detail.dart';
import 'package:library_management_app/screens/book_filter_category.dart';
import 'package:library_management_app/screens/books_screen.dart';
import 'package:library_management_app/widgets/custom_card.dart';
import '../models/book.dart';
import '../services/notification/notification_service.dart';
import 'my_borrowed_books_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final logoPath = 'assets/logo/Logolibrary1.png';
  final bookPath = 'assets/technology/computer_book.jpg';
  late PageController _pageController;
  int _currentPage = 0;
  int _currentIndex = 0;
  final categoryController = Get.put(CategoryController());
  final bookController = Get.put(BookController());
  final bannerController = Get.put(BannerController());

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    Future.delayed(const Duration(seconds: 3), autoSlide);
  }

  void autoSlide() {
    if (!mounted) return;

    _currentPage = (_currentPage + 1) % bannerController.banners.length;
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 3), autoSlide);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Image.asset(
          logoPath,
          width: 30,
        ),
        title: const Text(
          'Era Book',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // NotificationService.createNotification();
              Get.to(NotificationsScreen());
            },
            icon: Icon(
              Icons.notification_add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            _buildSearchComponent(),
            // _buildStockBookDetail(),
            _buildBanner(),
            _buildCategoryList(),
            Column(
              children: [
                _buildBookList(title: 'Book List'),
                _buildBookList(title: 'New arrival'),
                _buildBookList(title: 'Discount'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Obx(
      () {
        var banners = bannerController.banners;
        if (bannerController.isLoading.value) {
          return CircularProgressIndicator();
        }
        if (banners.isEmpty) {
          return Container();
        }
        return Container(
          height: 200,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: banners.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          banners[index].image ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              /// Dot Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  banners.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.indigo
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryList() {
    return Obx(
      () {
        if (categoryController.categories.isEmpty) {
          return CircularProgressIndicator();
        }
        return Container(
          width: double.infinity,
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category Book',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 6,
              ),
              Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      // final category = bookCategory[index];
                      var category = categoryController.categories[index];
                      return TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: primaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            Get.to(BookFilterCategory(
                              title: category.name!,
                              id: category.id.toString(),
                            ));
                          },
                          child: Text(
                            category.name!,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ));
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          width: 8,
                        ),
                    itemCount: categoryController.categories.length),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildBookList({required String title}) {
    return Obx(
      () {
        var books = bookController.books;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              height: 220,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final book = books[index];

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => BookDetail(book: book));
                    },
                    child: CustomCard(
                      book: book,
                      onTap: () {
                        Get.to(() => BookDetail(book: book));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchComponent() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        readOnly: true,
        onTap: () {
          Get.to(BooksScreen(
            fromHome: true,
          ));
        },
        decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(12)),
      ),
    );
  }
}
