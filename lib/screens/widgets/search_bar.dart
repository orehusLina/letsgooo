import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterPressed;

  const SearchBarWithFilter({
    super.key,
    required this.controller,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Найти мероприятие...',
              filled: true,
              fillColor: Colors.grey[850],
              prefixIcon: Icon(Icons.search, color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.filter_list, color: Colors.purpleAccent),
          onPressed: onFilterPressed,
          tooltip: 'Фильтры',
        )
      ],
    );
  }
}