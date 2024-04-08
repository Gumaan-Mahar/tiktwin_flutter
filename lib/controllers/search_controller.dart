import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tiktwin_flutter/core/constants.dart';
import 'package:tiktwin_flutter/models/user.dart';

class SearchController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  Future<void> searchUser(String typedUser) async {
    await EasyLoading.show(status: 'Searching...');
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var elem in query.docs) {
        retVal.add(User.fromSnap(elem));
      }
      return retVal;
    }));
    await EasyLoading.dismiss();
  }
}
