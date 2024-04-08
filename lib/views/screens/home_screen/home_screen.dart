import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktwin_flutter/controllers/home_controller.dart';
import 'package:tiktwin_flutter/core/constants.dart';
import 'package:tiktwin_flutter/views/widgets/custom_icon.dart';

import '../../../core/app_colors.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
          color: Colors.white,
          child: BottomNavigationBar(
            onTap: (idx) => {
              controller.pageIdx.value = idx,
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.bottomNavBarColor,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.white,
            currentIndex: controller.pageIdx.value,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: CustomIcon(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message, size: 30),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => pages[controller.pageIdx.value],
      ),
    );
  }
}
