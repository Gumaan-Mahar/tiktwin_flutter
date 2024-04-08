import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: const Center(
        child: Text(
          'Messages appear here.',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.borderColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
