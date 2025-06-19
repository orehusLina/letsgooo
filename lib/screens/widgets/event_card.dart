import 'package:flutter/material.dart';
import '../../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.25),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.asset(
              'assets/images/event${event.title.hashCode % 4 + 1}.jpg',
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.purpleAccent),
                    const SizedBox(width: 6),
                    Text("${event.date} ${event.time}"),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.purpleAccent),
                    const SizedBox(width: 6),
                    Expanded(child: Text(event.location)),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.event, size: 16, color: Colors.purpleAccent),
                    const SizedBox(width: 6),
                    Text(event.type),
                  ]),
                  if (event.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      event.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}