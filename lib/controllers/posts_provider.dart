import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindfullearn_dashboard/models/response/getPosts_model_res.dart';
import 'package:mindfullearn_dashboard/services/helpers/post_helper.dart';
import 'dart:html' as html;

class PostsNotifier extends ChangeNotifier {
  late Future<List<GetAllUsersPostsRes>> postsList;

  getPosts() {
    postsList = PostHelper.getPosts();
  }

  deletePost(String postId) {
    PostHelper.deletePost(postId).then((response) {
      if (response) {
        Get.snackbar("Post successfully deleted", "",
            colorText: Colors.white,
            backgroundColor: Colors.green,
            icon: const Icon(Icons.done));
        html.window.location.reload();
      } else if (!response) {
        Get.snackbar("Failed to delete Post", "Please try again",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.bookmark_remove_outlined));
      }
    });
  }
}
