import 'package:flutter/material.dart';
import 'package:tiktwin_flutter/core/app_colors.dart';
import 'package:tiktwin_flutter/core/constants.dart';
import 'package:tiktwin_flutter/controllers/video_controller.dart';
import 'package:tiktwin_flutter/views/screens/comment_screen/comment_screen.dart';
import 'package:tiktwin_flutter/views/screens/video_screen/components/profile_avatar.dart';
import 'package:tiktwin_flutter/views/widgets/video_player_iten.dart';
import 'package:get/get.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});

  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: Obx(
        () {
          return videoController.videoList.isEmpty
              ? const Center(
                  child: Text(
                    'No videos to display.',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.borderColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : PageView.builder(
                  itemCount: videoController.videoList.length,
                  controller:
                      PageController(initialPage: 0, viewportFraction: 1),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final data = videoController.videoList[index];
                    return Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: VideoPlayerItem(
                                videoUrl: data.videoUrl,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          data.username,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.55,
                                          child: Text(
                                            data.caption,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.music_note,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              data.songName,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.more_vert),
                                      color: Colors.white,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: Get.width * 0.2,
                          height: Get.height * 0.45,
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProfileAvatar(
                                profilePhoto: data.profilePhoto,
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        videoController.likeVideo(data.id),
                                    child: Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color: data.likes
                                              .contains(authController.user.uid)
                                          ? Colors.red
                                          : AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    data.likes.length.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.primary,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CommentScreen(
                                          id: data.id,
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.comment,
                                      size: 40,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    data.commentCount.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.primary,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.reply,
                                      size: 40,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    data.shareCount.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.primary,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
