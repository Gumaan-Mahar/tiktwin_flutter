import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tiktwin_flutter/controllers/auth_controller.dart';
import 'package:tiktwin_flutter/views/screens/login_screen/login_screen.dart';

import 'core/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
  });
  EasyLoading.instance
    ..textStyle = const TextStyle(fontSize: 12, color: Colors.white)
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.black
    ..radius = 12
    ..contentPadding = const EdgeInsets.all(14)
    ..indicatorSize = 30
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..userInteractions = false
    ..displayDuration = const Duration(seconds: 1)
    ..dismissOnTap = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'TikTwin',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          primaryColor: AppColors.primary,
          appBarTheme: const AppBarTheme().copyWith(
            systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: AppColors.bottomNavBarColor,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarDividerColor: null,
              statusBarColor: AppColors.primary,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
          ),
          colorScheme: const ColorScheme.dark().copyWith(
            error: Colors.red,
          )),
      home: LoginScreen(),
    );
  }
}
