class Habit {
  final String id;
  final String doUrl;
  final String statement;
  final String dontUrl;

  Habit({
    required this.id,
    required this.doUrl,
    required this.statement,
    required this.dontUrl,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['_id'],
      doUrl: json['doUrl'],
      statement: json['statement'],
      dontUrl: json['dontUrl'],
    );
  }
}
