import 'package:flutter/material.dart';
import 'package:mindfullearn_dashboard/controllers/posts_provider.dart';
import 'package:mindfullearn_dashboard/views/common/post_card_widget.dart';
import 'package:provider/provider.dart';

class PostsListPage extends StatefulWidget {
  const PostsListPage({
    super.key,
  });

  @override
  State<PostsListPage> createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  @override
  Widget build(BuildContext context) {
    bool isCollapsed = MediaQuery.of(context).size.width <= 800;
    return Scaffold(
      body: Consumer<PostsNotifier>(builder: (context, postNotifier, child) {
        postNotifier.getPosts();
        return Padding(
          padding: isCollapsed
              ? const EdgeInsets.only(left: 20)
              : const EdgeInsets.only(
                  left: 200,
                ),
          child: FutureBuilder(
              future: postNotifier.postsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final posts = snapshot.data;
                  return ListView.builder(
                      itemCount: posts!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return PostCardWidget(
                          id: post.id,
                          title: post.title,
                          content: post.postContent,
                          imageUrl: post.postPicture,
                          likes: post.likes.length,
                          comments: post.comments.length,
                          postDate: post.createdAt,
                          userName: post.userName,
                          userProfileImageUrl: post.userImage,
                          listComments: post.comments,
                        );
                      });
                }
              }),
        );
      }),
    );
  }
}
