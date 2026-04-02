class Task {
  int id;
  String title;
  List<String> tags;
  int nbhours;
  int difficulty;
  String description;
  Task({
    required this.id,
    required this.title,
    required this.tags,
    required this.nbhours,
    required this.difficulty,
    required this.description,
  });
  static int nb=50;

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      nbhours: json['nbhours'] ?? 0,
      difficulty: json['difficuty'] ?? 0,
      description: json['description'] ?? '',
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'tags': tags.join(',') ,
      'nbhours': nbhours,
      'difficulty': difficulty,
      'description': description,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      tags: (map['tags'] as String).split(','),
      nbhours: map['nbhours'] as int,
      difficulty: map['difficulty'] as int,
      description: map['description'] as String,
    );
  }
}
