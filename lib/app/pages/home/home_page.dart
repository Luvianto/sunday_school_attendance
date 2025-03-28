import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_app_bar.dart';
import 'package:sunday_school_attendance/app/pages/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => CustomAppBar(
            title: Text(controller.currentTitle),
            actions: controller.currentActions,
          ),
        ),
      ),
      body: Obx(
        () => controller.currentPage,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: controller.items,
          onTap: controller.changePage,
          currentIndex: controller.currentTab.value.index,
        ),
      ),
      floatingActionButton: controller.currentFab,
    );
  }
}
