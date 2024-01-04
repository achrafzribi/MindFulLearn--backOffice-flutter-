import 'dart:convert';

List<GetAllUsersPostsRes> getAllUsersPostsResFromJson(String str) =>
    List<GetAllUsersPostsRes>.from(
        json.decode(str).map((x) => GetAllUsersPostsRes.fromJson(x)));

String getAllUsersPostsResToJson(List<GetAllUsersPostsRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllUsersPostsRes {
  final int type;
  final String id;
  final String title;
  final String postContent;
  final String postPicture;
  final List<Comment> comments;
  final String userImage;
  final String userName;
  final String userId;
  final DateTime createdAt;
  final List<Like> likes;

  GetAllUsersPostsRes({
    required this.type,
    required this.id,
    required this.title,
    required this.postContent,
    required this.postPicture,
    required this.comments,
    required this.userImage,
    required this.userName,
    required this.userId,
    required this.createdAt,
    required this.likes,
  });

  factory GetAllUsersPostsRes.fromJson(Map<String, dynamic> json) =>
      GetAllUsersPostsRes(
        type: json["type"],
        id: json["_id"],
        title: json["title"],
        postContent: json["PostContent"],
        postPicture: json["PostPicture"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        userImage: json["userImage"],
        userName: json["userName"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "title": title,
        "PostContent": postContent,
        "PostPicture": postPicture,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "userImage": userImage,
        "userName": userName,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
      };
}

class Comment {
  final String user;
  final String content;
  final String id;
  final DateTime createdAt;

  Comment({
    required this.user,
    required this.content,
    required this.id,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: json["user"],
        content: json["content"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "content": content,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}

class Like {
  final String user;
  final String postId;
  final String id;

  Like({
    required this.user,
    required this.postId,
    required this.id,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        user: json["user"],
        postId: json["postId"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "postId": postId,
        "_id": id,
      };
}
