import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktwin_flutter/controllers/auth_controller.dart';
import 'package:tiktwin_flutter/views/screens/add_video_screen/add_video_screen.dart';
import 'package:tiktwin_flutter/views/screens/messages_screen/messages_screen.dart';
import 'package:tiktwin_flutter/views/screens/profile_screen/profile_screen.dart';
import 'package:tiktwin_flutter/views/screens/search_screen/search_screen.dart';
import 'package:tiktwin_flutter/views/screens/video_screen/video_screen.dart';

List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  const MessagesScreen(),
  ProfileScreen(uid: authController.user.uid),
];

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;
