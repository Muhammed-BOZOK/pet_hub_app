import 'comment_model.dart';

class Post {
  String? postId;
  String? userId;
  DateTime? timestamp;
  String? content;
  int? likes;
  List<Comment>? comments;

  Post({
    this.postId,
    this.userId,
    this.timestamp,
    this.content,
    this.likes,
    this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['post_id'],
      userId: json['user_id'],
      timestamp: DateTime.parse(json['timestamp']),
      content: json['content'],
      likes: json['likes'],
      comments: (json['comments'] as List<dynamic>).map((comment) => Comment.fromJson(comment)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'post_id': postId,
    'user_id': userId,
    'timestamp': timestamp!.toIso8601String(),
    'content': content,
    'likes': likes,
    'comments': comments!.map((comment) => comment.toJson()).toList(),
  };
}
