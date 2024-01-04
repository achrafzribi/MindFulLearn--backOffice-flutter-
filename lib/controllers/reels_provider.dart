import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mindfullearn_dashboard/models/response/getPosts_model_res.dart';
import 'package:mindfullearn_dashboard/services/helpers/post_helper.dart';
import 'package:mindfullearn_dashboard/services/helpers/reel_helper.dart';

class ReelsNotifier extends ChangeNotifier {
  late Future<List<GetAllUsersPostsRes>> reelsList;

  getReels() {
    reelsList = ReelHelper.getReels();
  }

  deleteReel(String postId) {
    PostHelper.deletePost(postId).then((response) {
      if (response) {
        Get.snackbar("Reel successfully deleted", "",
            colorText: Colors.white,
            backgroundColor: Colors.green,
            icon: const Icon(Icons.done));
        html.window.location.reload();
      } else if (!response) {
        Get.snackbar("Failed to delete Reel", "Please try again",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.bookmark_remove_outlined));
      }
    });
  }
}
