class CommentModel {
  String? commentId;
  String? postId;
  String? userId;
  String? userPhotoUrl;
  String? userName;
  DateTime? timestamp;
  String? content;

  CommentModel({
    this.commentId,
    this.postId,
    this.userId,
    this.userPhotoUrl,
    this.userName,
    this.timestamp,
    this.content,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['comment_id'],
      postId: json['post_id'],
      userId: json['user_id'],
      userPhotoUrl: json['userPhotoUrl'],
      userName: json['userName'],
      timestamp:
          json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() => {
        'comment_id': commentId,
        'post_id': postId,
        'user_id': userId,
        'userPhotoUrl': userPhotoUrl,
        'userName': userName,
        'timestamp': timestamp?.toIso8601String(),
        'content': content,
      };
}
