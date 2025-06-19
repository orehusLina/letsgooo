class Event {
  final String title;
  final String date;
  final String time;
  final String location;
  final String type;
  final String description;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.type,
    required this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      type: json['type'],
      description: json['description'] ?? '',
    );
  }
}
