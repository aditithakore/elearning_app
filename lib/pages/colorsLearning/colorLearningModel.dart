class ColorLearning {
  final String id;
  final String name;
  final String imageUrl;

  ColorLearning({required this.id, required this.name, required this.imageUrl});

  factory ColorLearning.fromJson(Map<String, dynamic> json) {
    return ColorLearning(
      id: json['_id'] , // Add default value
      name: json['name'] , // Add default value
      imageUrl: json['imageUrl'], // Add default value
    );
  }
}
