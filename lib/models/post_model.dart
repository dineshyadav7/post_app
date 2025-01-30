class PostModel {
  final int id;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.body,
    required this.title,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      body: json['body'] ?? "",
      title: json['title'] ?? "",
    );
  }
  // Convert PostModel to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
