class Number {
  final String id;
  final String name;
  final String imageUrl;

  Number({required this.id, required this.name, required this.imageUrl});

  factory Number.fromJson(Map<String, dynamic> json) {
    return Number(
      id: json['_id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}