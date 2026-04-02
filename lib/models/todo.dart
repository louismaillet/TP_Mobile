class Todo{
  final int _id;
  final String _title;
  final bool _completed;

  Todo(this._id, this._title, this._completed);

  int get id => _id;
  String get title => _title;
  bool get completed => _completed;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['id'], json['title'], json['completed']);
  }
}