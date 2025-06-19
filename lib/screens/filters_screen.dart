import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  final String currentCity;
  final String currentDateFilter;
  final List<String> selectedTypes;

  const FiltersScreen({
    super.key,
    required this.currentCity,
    required this.currentDateFilter,
    required this.selectedTypes,
  });

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late String city;
  late String date;
  late List<String> types;

  final allTypes = ['лекция', 'митап', 'вечеринка', 'концерт', 'выставка'];
  final allDates = ['Сегодня', 'Завтра', 'На выходных', 'Выбрать дату'];

  @override
  void initState() {
    super.initState();
    city = widget.currentCity;
    date = widget.currentDateFilter;
    types = [...widget.selectedTypes];
  }

  void toggleType(String type) {
    setState(() {
      if (types.contains(type)) {
        types.remove(type);
      } else {
        types.add(type);
      }
    });
  }

  void applyFilters() {
    Navigator.pop(context, {
      'city': city,
      'date': date,
      'types': types,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Фильтры")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text("Город", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Введите город",
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => city = val,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            Text("Дата", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: allDates.map((d) {
                return ChoiceChip(
                  label: Text(d),
                  selected: date == d,
                  onSelected: (_) => setState(() => date = d),
                  selectedColor: Colors.purpleAccent.withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: date == d ? Colors.purpleAccent : Colors.white,
                  ),
                  backgroundColor: Colors.grey[800],
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            Text("Интересы", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: allTypes.map((t) {
                return FilterChip(
                  label: Text(t),
                  selected: types.contains(t),
                  onSelected: (_) => toggleType(t),
                  selectedColor: Colors.purpleAccent.withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: types.contains(t) ? Colors.purpleAccent : Colors.white,
                  ),
                  backgroundColor: Colors.grey[800],
                  checkmarkColor: Colors.purpleAccent,
                );
              }).toList(),
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: applyFilters,
              child: Text("Применить"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
