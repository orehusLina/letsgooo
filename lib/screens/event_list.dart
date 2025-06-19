import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/json_loader.dart';
import 'widgets/event_card.dart';
import 'widgets/search_bar.dart';
import 'filters_screen.dart';

class EventListScreen extends StatefulWidget {
  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> allEvents = [];
  List<Event> filteredEvents = [];

  String selectedCity = '';
  String selectedDateFilter = '';
  List<String> selectedTypes = [];
  String searchQuery = '';

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadEvents().then((value) {
      setState(() {
        allEvents = value;
        filteredEvents = value;
      });
    });
  }

  void applyFilters() {
    setState(() {
      filteredEvents = allEvents.where((event) {
        final matchesCity = selectedCity.isEmpty || event.location.contains(selectedCity);
        final matchesType = selectedTypes.isEmpty || selectedTypes.contains(event.type);
        final matchesSearch = searchQuery.isEmpty || event.title.toLowerCase().contains(searchQuery.toLowerCase());
        // TODO: добавить фильтр по дате
        return matchesCity && matchesType && matchesSearch;
      }).toList();
    });
  }

  Future<void> openFiltersScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FiltersScreen(
          currentCity: selectedCity,
          currentDateFilter: selectedDateFilter,
          selectedTypes: selectedTypes,
        ),
      ),
    );

    if (result != null && result is Map) {
      setState(() {
        selectedCity = result['city'];
        selectedDateFilter = result['date'];
        selectedTypes = List<String>.from(result['types']);
      });
      applyFilters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("События"),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            SearchBarWithFilter(
              controller: searchController,
              onFilterPressed: openFiltersScreen,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  return EventCard(event: filteredEvents[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
