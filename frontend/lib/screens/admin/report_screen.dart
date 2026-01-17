import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_app/constants/color_const.dart';
import '../../controllers/report_controller.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});

  final controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text("Reports"),
        actions: [
          PopupMenuButton<String>(
            onSelected: controller.exportReport,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: "pdf",
                child: const Text("Export PDF"),
                onTap: () async {
                  await controller.exportReport("pdf");
                  print('export to pdf');
                  print('type : ${controller.reportType.value}');
                },
              ),
              PopupMenuItem(
                value: "csv",
                child: Text("Export CSV"),
                onTap: () async {
                  await controller.exportReport("csv");
                  print('export to csv');
                  print('type : ${controller.reportType.value}');
                },
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _tabButton("Monthly", ReportType.monthly),
              const SizedBox(width: 10),
              _tabButton("Yearly", ReportType.yearly),
            ],
          ),
        ));
  }

  Widget _tabButton(String title, ReportType type) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.reportType.value == type
              ? primaryColor
              : Colors.grey.shade300,
          foregroundColor:
              controller.reportType.value == type ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => controller.changeType(type),
        child: Text(title),
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: controller.fetchReports,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _summaryCards(),
            const SizedBox(height: 20),
            _popularBooks(),
          ],
        ),
      );
    });
  }

  Widget _summaryCards() {
    return Row(
      children: [
        _summaryCard(
          "Total Borrows",
          controller.report.value.totalBorrows.toString(),
          Icons.book,
        ),
        const SizedBox(width: 12),
        _summaryCard(
          "Total Returns",
          controller.report.value.totalReturns.toString(),
          Icons.assignment_turned_in,
        ),
      ],
    );
  }

  Widget _summaryCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 30),
              const SizedBox(height: 8),
              Text(value,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popularBooks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Current Borrowed Books",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...?controller.report.value.currentBorrow?.map(
          (book) => Card(
            child: ListTile(
              leading: const Icon(Icons.book),
              title: Text(book.title ?? ''),
              trailing: Text("${book.borrowCount} times"),
            ),
          ),
        ),
      ],
    );
  }
}
