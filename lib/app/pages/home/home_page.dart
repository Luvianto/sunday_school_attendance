import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/pages/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.labels.elementAt(controller.currentIndex.value)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        shadowColor: Theme.of(context).colorScheme.outlineVariant,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => controller.pages.elementAt(controller.currentIndex.value),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: controller.items,
          onTap: controller.changePage,
          currentIndex: controller.currentIndex.value,
        ),
      ),
    );
  }
}
