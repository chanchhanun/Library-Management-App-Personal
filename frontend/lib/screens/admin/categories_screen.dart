import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_const.dart';
import '../../controllers/category_controller.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final controller = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () async {
        await controller.fetchCategory();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.categories.isEmpty) {
          return const Center(
            child: Text(
              'No categories found',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final category = controller.categories[index];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    category.name![0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  category.name ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  category.description ?? 'No description',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // trailing: PopupMenuButton(
                //   itemBuilder: (context) => [
                //     const PopupMenuItem(
                //       value: 'edit',
                //       child: Text('Edit'),
                //     ),
                //     const PopupMenuItem(
                //       value: 'delete',
                //       child: Text('Delete'),
                //     ),
                //   ],
                //   onSelected: (value) {
                //     if (value == 'edit') {
                //       // edit category
                //     } else if (value == 'delete') {
                //       // delete category
                //     }
                //   },
                // ),
                onTap: () {
                  // view category details
                },
              ),
            );
          },
        );
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // TODO: add category
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
