import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktwin_flutter/controllers/add_video_controller.dart';
import 'package:tiktwin_flutter/core/app_colors.dart';

import '../../../controllers/home_controller.dart';

class AddVideoScreen extends GetView<AddVideoController> {
  const AddVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddVideoController());
    return Center(
      child: SizedBox(
        width: Get.width,
        height: Get.height * 0.4,
        child: AlertDialog(
          backgroundColor: AppColors.bottomNavBarColor,
          title: const Text(
            'Select an option',
            style: TextStyle(
              color: AppColors.borderColor,
              fontSize: 16,
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => controller.pickVideo(ImageSource.gallery, context),
                child: const Row(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 22,
                      color: AppColors.borderColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Choose from gallery',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () => controller.pickVideo(ImageSource.camera, context),
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 22,
                      color: AppColors.borderColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Record a video',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final HomeController homeController = Get.find();
                homeController.pageIdx.value = 0;
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
