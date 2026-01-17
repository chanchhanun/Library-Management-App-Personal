class Notification {
  final int id;
  final String title;
  final String message;
  final String type; // due | overdue
  final String date;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.date,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      date: json['date'],
    );
  }
}
