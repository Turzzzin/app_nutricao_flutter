import 'package:flutter/material.dart';

Widget customDropdown({
  required List<Map<String, dynamic>> options, 
  required int? selectedId,  
  required ValueChanged<int?> onChanged,
  required String text,
}) {
 return DropdownButton<int>(
    hint: Text(text),
    value: selectedId, // Valor selecionado
    icon: Icon(Icons.arrow_drop_down),
    iconSize: 24,
    elevation: 16,
    style: TextStyle(color: Colors.deepPurple),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    onChanged: onChanged, 
    items: options.map<DropdownMenuItem<int>>((Map<String, dynamic> item) {
      return DropdownMenuItem<int>(
        value: item['id'], // Define o ID como valor
        child: Text(item['nome']), 
      );
    }).toList(),
  );
}