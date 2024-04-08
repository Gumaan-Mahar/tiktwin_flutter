import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktwin_flutter/core/constants.dart';
import 'package:tiktwin_flutter/models/user.dart' as model;
import 'package:tiktwin_flutter/views/screens/login_screen/login_screen.dart';
import 'package:tiktwin_flutter/views/screens/home_screen/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  Rx<String> imagePath = ''.obs;
  XFile? pickedFile;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      pickedFile = pickedImage;
      if (pickedFile != null) {
        imagePath.value = pickedFile!.path;
      }
    }
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  Future<void> registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        await EasyLoading.show(status: 'Registering...');
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        await EasyLoading.dismiss();
      } else {
        await EasyLoading.dismiss();
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await EasyLoading.show(status: 'Logging in...');
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        await EasyLoading.dismiss();
      } else {
        await EasyLoading.dismiss();
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      await EasyLoading.dismiss();
      Get.snackbar(
        'Error Loggin gin',
        e.toString(),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
