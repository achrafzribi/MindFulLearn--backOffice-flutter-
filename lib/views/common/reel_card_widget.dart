import 'dart:html';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:mindfullearn_dashboard/controllers/posts_provider.dart';
import 'package:provider/provider.dart';
import 'package:reels_viewer/reels_viewer.dart';
import 'package:video_player/video_player.dart';
import 'package:mindfullearn_dashboard/models/response/getPosts_model_res.dart';

class ReelCardWidget extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final int likes;
  final List<Comment> listComments;

  final DateTime postDate;
  final String userName;
  final String userProfileImageUrl;

  const ReelCardWidget({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.postDate,
    required this.userName,
    required this.userProfileImageUrl,
    required this.listComments,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 600,
      child: Consumer<PostsNotifier>(builder: (context, psotNotifier, child) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Post Image
              imageUrl.isNotEmpty
                  ? SizedBox(
                      height: 300,
                      width: 400,
                      child: Chewie(
                        controller: ChewieController(
                          videoPlayerController:
                              VideoPlayerController.network(imageUrl),
                          autoPlay: false,
                          looping: true,
                        ),
                      ),
                    )
                  : Container(),

              // Post Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              // Post Content
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(content),
              ),

              // Post Details (Likes, Comments, Date)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Likes: $likes'),
                    DropdownButton<Comment>(
                      hint: Text('Comments : ${listComments.length}'),
                      value: null, // Initially no value is selected
                      onChanged: (Comment? selectedComment) {
                        // Handle the selected comment
                        print(selectedComment!.id);
                      },
                      items: listComments.map((Comment comment) {
                        return DropdownMenuItem<Comment>(
                          value: comment,
                          child: SizedBox(
                            width: 500,
                            child: ListTile(
                              title: Text(comment.user),
                              subtitle: Text(comment.content),
                              leading: const CircleAvatar(),
                              trailing:  IconButton(
                                  onPressed: () => psotNotifier.deletePostComment(id,comment.id),
                                  icon: const Icon(Icons.delete))

                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Text('Date: ${postDate.toLocal()}'),
                  ],
                ),
              ),

              // User Information (Name, Profile Image)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userProfileImageUrl),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(userName),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => psotNotifier.deletePost(id),
                      icon: const Icon(Icons.delete))
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
