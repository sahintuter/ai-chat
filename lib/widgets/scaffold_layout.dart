import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import 'bottom_navigation_bar.dart';

class ScaffoldLayout extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool automaticallyImplyLeading;

  const ScaffoldLayout({
    super.key,
    required this.body,
    required this.title,
    this.actions,
    this.floatingActionButton,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
        automaticallyImplyLeading: automaticallyImplyLeading,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: GetBuilder<NavigationController>(
        builder: (controller) => CustomBottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
        ),
      ),
    );
  }
}
