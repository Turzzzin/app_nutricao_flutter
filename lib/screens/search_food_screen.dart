import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/custom_list_view_food.dart';
import '../utils/database_service.dart';


class SearchFoodScreen extends StatefulWidget {
  const SearchFoodScreen({super.key});

  @override
  State<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {

  final _nameController = TextEditingController();

  List<Map<String, dynamic>> _alimentosList = [];

  Future<void> _getAlimentos() async {
    final alimento = _nameController.text.trimRight().trimLeft();
    final alimentos = await DatabaseService.getLikeAlimentos(alimento);
    setState(() {
      _alimentosList = alimentos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Cardapio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _nameController,
              hintText: 'Nome do Alimento',
              obscureText: false,
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {
                _getAlimentos();
              },
              text: 'Buscar Alimento',
            ),
            const SizedBox(height: 16),
            CustomListView(options: _alimentosList, title: "Alimentos"),
          ],
        ),  
      )
    );
  }
}