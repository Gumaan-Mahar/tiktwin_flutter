import 'package:flutter/material.dart';
import 'package:tiktwin_flutter/controllers/search_controller.dart'
    as search_controller;
import 'package:get/get.dart';
import 'package:tiktwin_flutter/core/app_colors.dart';
import 'package:tiktwin_flutter/models/user.dart';
import 'package:tiktwin_flutter/views/screens/profile_screen/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final search_controller.SearchController searchController =
      Get.put(search_controller.SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: AppColors.primary,
        title: SizedBox(
          height: Get.height * 0.08,
          child: TextFormField(
            controller: searchController.searchTextController,
            decoration: InputDecoration(
              filled: false,
              hintText: 'Search for users',
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.white60,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.white60),
              suffixIcon: GestureDetector(
                child: const Icon(Icons.send, color: Colors.white),
                onTap: () => {
                  searchController
                      .searchUser(searchController.searchTextController.text),
                },
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                  )),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: AppColors.borderColor,
                ),
              ),
            ),
            onFieldSubmitted: (value) async =>
                await searchController.searchUser(value),
          ),
        ),
      ),
      body: Obx(
        () => searchController.searchedUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search results appear here',
                  style: TextStyle(
                    color: AppColors.borderColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(uid: user.uid),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePhoto,
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
