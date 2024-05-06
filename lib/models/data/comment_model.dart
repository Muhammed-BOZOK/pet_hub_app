class Comment {
  String? commentId;
  String? postId;
  String? userId;
  DateTime? timestamp;
  String? content;

  Comment({
    this.commentId,
    this.postId,
    this.userId,
    this.timestamp,
    this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['comment_id'],
      postId: json['post_id'],
      userId: json['user_id'],
      timestamp: DateTime.parse(json['timestamp']),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() => {
    'comment_id': commentId,
    'post_id': postId,
    'user_id': userId,
    'timestamp': timestamp!.toIso8601String(),
    'content': content,
  };
}