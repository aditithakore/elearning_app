class AlphabetLearning {
  final String id;
  final String alphabetUrl;
  final String word;
  final String imageUrl;

  AlphabetLearning({
    required this.id,
    required this.alphabetUrl,
    required this.word,
    required this.imageUrl,
  });

  factory AlphabetLearning.fromJson(Map<String, dynamic> json) {
    return AlphabetLearning(
      id: json['_id'],
      alphabetUrl: json['alphabetUrl'],
      word: json['word'],
      imageUrl: json['imageUrl'],
    );
  }
}
