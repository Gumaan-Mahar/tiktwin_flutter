import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktwin_flutter/core/constants.dart';
import 'package:tiktwin_flutter/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

import '../../../core/app_colors.dart';

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({
    super.key,
    required this.id,
  });

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CommentController commentController = Get.put(CommentController());
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          // leading: CircleAvatar(
                          //   backgroundColor: Colors.black,
                          //   backgroundImage: NetworkImage(comment.profilePhoto),
                          // ),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage:
                                    NetworkImage(comment.profilePhoto),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${comment.username}  ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        tago.format(
                                          comment.datePublished.toDate(),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${comment.likes.length} likes',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.63,
                                    child: Text(
                                      comment.comment,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // subtitle: Text(
                          //   comment.comment,
                          //   style: const TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          trailing: GestureDetector(
                            onTap: () =>
                                commentController.likeComment(comment.id),
                            child: Icon(
                              Icons.favorite,
                              size: 25,
                              color: comment.likes
                                      .contains(authController.user.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        );
                      });
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () async =>
                      await commentController.postComment(_commentController.text),
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
