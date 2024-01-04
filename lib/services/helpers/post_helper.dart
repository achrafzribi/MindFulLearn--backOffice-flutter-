import 'package:http/http.dart' as https;
import 'package:mindfullearn_dashboard/models/response/getPosts_model_res.dart';
import 'package:mindfullearn_dashboard/services/config.dart';

class PostHelper {
  static var client = https.Client();

  static Future<List<GetAllUsersPostsRes>> getPosts() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*'

    };

    var url = Uri.https(Config.apiUrl, Config.postUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var postsList = getAllUsersPostsResFromJson(response.body);
      return postsList;
    } else {
      throw Exception("Failed to get the posts");
    }
  }

  static Future<bool> deletePost(String postId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.postUrl}/$postId");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> deletePostComment(String postId,String CommentID) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.postUrl}/$postId/comments/$CommentID");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
