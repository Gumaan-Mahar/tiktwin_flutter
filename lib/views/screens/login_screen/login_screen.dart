import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktwin_flutter/controllers/auth_controller.dart';

import '../../../core/app_colors.dart';
import '../../../core/constants.dart';
import '../../widgets/text_input_field.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends GetView<AuthController> {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                        height: Get.height * 0.5,
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextInputField(
                                      controller: _emailController,
                                      labelText: 'Email',
                                      icon: Icons.email,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextInputField(
                                      controller: _passwordController,
                                      labelText: 'Password',
                                      icon: Icons.lock,
                                      isObscure: true,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
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
                                      await authController.loginUser(
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                    }
                                  },
                                  child: const Center(
                                    child: Text(
                                      'Login',
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
                          'New here? ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          ),
                          child: Text(
                            'Sign up now',
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
