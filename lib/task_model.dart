class Task {
  String id;
  String title;
  String description;
  DateTime dueDate;
  bool isImportant;
  String notes;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isImportant,
    required this.notes,
  });
}
