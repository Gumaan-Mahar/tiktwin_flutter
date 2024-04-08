import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../views/screens/confirm_screen/confirm_screen.dart';

class AddVideoController extends GetxController {

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      await Get.to(
        () => ConfirmScreen(
          videoFile: File(video.path),
          videoPath: video.path,
        ),
      );
    }
  }
}
