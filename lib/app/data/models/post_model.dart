class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;
  final String? authorName;
  final DateTime? createdAt;
  final int likesCount;

  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.authorName,
    this.createdAt,
    this.likesCount = 0,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: (json['id'] is int)
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      userId: (json['userId'] is int)
          ? json['userId'] as int
          : (json['user_id'] is int)
              ? json['user_id'] as int
              : int.tryParse(json['userId']?.toString() ??
                      json['user_id']?.toString() ??
                      '1') ??
                  1,
      title: (json['title'] ?? '').toString(),
      body: (json['body'] ?? '').toString(),
      authorName: json['authorName'] as String? ??
          json['author'] as String? ??
          'Author #${json['userId'] ?? 1}',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : DateTime.now().subtract(Duration(
              hours: ((json['id'] is int ? json['id'] : 1) as int) % 48)),
      likesCount: (json['likesCount'] is int)
          ? json['likesCount'] as int
          : ((json['id'] is int ? json['id'] : 1) as int) * 7 % 100,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'authorName': authorName,
      'createdAt': createdAt?.toIso8601String(),
      'likesCount': likesCount,
    };
  }

  PostModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
    String? authorName,
    DateTime? createdAt,
    int? likesCount,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
