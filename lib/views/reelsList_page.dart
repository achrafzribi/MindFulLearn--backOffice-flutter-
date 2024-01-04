import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:mindfullearn_dashboard/controllers/reels_provider.dart';
import 'package:mindfullearn_dashboard/views/common/reel_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ReelsListPage extends StatefulWidget {
  const ReelsListPage({
    super.key,
  });

  @override
  State<ReelsListPage> createState() => _ReelsListPageState();
}

class _ReelsListPageState extends State<ReelsListPage> {
  @override
  Widget build(BuildContext context) {
    bool isCollapsed = MediaQuery.of(context).size.width <= 800;
    return Scaffold(
      body: Consumer<ReelsNotifier>(builder: (context, reelNotifier, child) {
        reelNotifier.getReels();
        return Padding(
          padding: isCollapsed
              ? const EdgeInsets.only(left: 20)
              : const EdgeInsets.only(
                  left: 200,
                ),
          child: FutureBuilder(
              future: reelNotifier.reelsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final reels = snapshot.data;
                  return ListView.builder(
                      itemCount: reels!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final reel = reels[index];

                        return ReelCardWidget(
                          id: reel.id,
                          title: reel.title,
                          content: reel.postContent,
                          imageUrl: reel.postPicture,
                          likes: reel.likes.length,
                          listComments: reel.comments,
                          postDate: reel.createdAt,
                          userName: reel.userName,
                          userProfileImageUrl: reel.userImage,
                        );
                      });
                }
              }),
        );
      }),
    );
  }
}
