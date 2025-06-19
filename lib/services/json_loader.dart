import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/event.dart';

Future<List<Event>> loadEvents() async {
  final response = await rootBundle.loadString('parser/parsed_events.json');
  final data = json.decode(response) as List<dynamic>;
  return data.map((e) => Event.fromJson(e)).toList();
}
