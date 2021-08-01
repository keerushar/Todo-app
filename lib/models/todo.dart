class Todo {
  final int? id;
  final int? taskId;
  final String? title;
  final int? isChecked;

  Todo({this.id, this.taskId, this.title, this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'title': title,
      'isChecked': isChecked,
    };
  }
}
