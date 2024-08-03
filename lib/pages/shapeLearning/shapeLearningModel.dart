class ShapeLearning {
  final String id;
  final String name;
  final String imageUrl;

  ShapeLearning({required this.id, required this.name, required this.imageUrl});

  factory ShapeLearning.fromJson(Map<String, dynamic> json) {
    return ShapeLearning(
      id: json['_id'] , // Add default value
      name: json['name'] , // Add default value
      imageUrl: json['imageUrl'], // Add default value
    );
  }
}
