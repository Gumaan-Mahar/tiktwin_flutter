import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktwin_flutter/core/constants.dart';
import 'package:tiktwin_flutter/controllers/auth_controller.dart';
import 'package:tiktwin_flutter/views/screens/login_screen/login_screen.dart';
import 'package:tiktwin_flutter/views/widgets/text_input_field.dart';

import '../../../core/app_colors.dart';

class SignupScreen extends GetView<AuthController> {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: AppColors.primary,
                        width: Get.width,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: AppColors.backgroundColor,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'TikTwin',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Container(
                        height: Get.height * 0.7,
                        width: Get.width,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Obx(
                                      () => CircleAvatar(
                                        radius: 64,
                                        backgroundImage:
                                            controller.imagePath.value != ''
                                                ? FileImage(
                                                    File(
                                                      controller
                                                          .imagePath.value,
                                                    ),
                                                  ) as ImageProvider<Object>
                                                : const AssetImage(
                                                    'assets/images/blank_profile_picture.webp',
                                                  ),
                                        backgroundColor: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primary,
                                      ),
                                      child: IconButton(
                                        onPressed: () =>
                                            authController.pickImage(),
                                        icon: const Icon(
                                          Icons.add_a_photo,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextInputField(
                                    controller: _usernameController,
                                    labelText: 'Username',
                                    icon: Icons.person,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextInputField(
                                    controller: _emailController,
                                    labelText: 'Email',
                                    icon: Icons.email,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextInputField(
                                    controller: _passwordController,
                                    labelText: 'Password',
                                    icon: Icons.lock,
                                    isObscure: true,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: Get.width * 0.5,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final profilePhoto = File(
                                            authController.pickedFile!.path);
                                        await authController.registerUser(
                                          _usernameController.text,
                                          _emailController.text,
                                          _passwordController.text,
                                          profilePhoto,
                                        );
                                      }
                                    },
                                    child: const Center(
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        const Text(
                          'Have an account? ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          ),
                          child: Text(
                            'Log in now',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
