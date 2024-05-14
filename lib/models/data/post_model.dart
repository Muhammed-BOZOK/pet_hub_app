import 'comment_model.dart';

class PostModel {
  String? postId;
  String? userId;
  String? userName;
  DateTime? timestamp;
  String? description;
  String? postImageUrl;
  String? likes;
  List<CommentModel>? comments;

  PostModel({
    this.postId,
    this.userId,
    this.userName,
    this.timestamp,
    this.description,
    this.postImageUrl,
    this.likes,
    this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'],
      userId: json['userId'],
      userName: json['userName'],
      timestamp: DateTime.parse(json['timestamp']),
      description: json['description'],
      postImageUrl: json['postImageUrl'],
      likes: json['likes'],
      comments: json['comments'] != null
          ? (json['comments'] as List)
              .map((e) => CommentModel.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'userName': userName,
      'timestamp': timestamp?.toIso8601String(),
      'description': description,
      'postImageUrl': postImageUrl,
      'likes': likes,
      'comment': comments?.map((commet) => commet.toJson()).toList(),
    };
  }
}
