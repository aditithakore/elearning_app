class BodyPart {
  final String id;
  final String name;
  final String imageUrl;

  BodyPart({required this.id, required this.name, required this.imageUrl});

  factory BodyPart.fromJson(Map<String, dynamic> json) {
    return BodyPart(
      id: json['_id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}