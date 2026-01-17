class Author {
  final int id;
  final String name;
  final String bio;
  final DateTime createdAt;

  Author({
    required this.id,
    required this.name,
    required this.bio,
    required this.createdAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      bio: json['bio'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
    };
  }
}
