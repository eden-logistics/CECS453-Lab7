class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime? dateTime;

  String get date => "${dateTime!.month}/${dateTime!.day}/${dateTime!.year}";

  Note({this.id, required this.title, required this.description, required this.dateTime});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description, 'date': dateTime!.toIso8601String()};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dateTime: DateTime.parse(map['date']),
    );
  }
}
