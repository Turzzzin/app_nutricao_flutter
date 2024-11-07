import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/custom_list_view_menu.dart';
import '../utils/database_service.dart';


class SearchMenuScreen extends StatefulWidget {
  const SearchMenuScreen({super.key});

  @override
  State<SearchMenuScreen> createState() => _SearchMenuScreen();
}

class _SearchMenuScreen extends State<SearchMenuScreen> {

  final _nameController = TextEditingController();

  Map<String, dynamic> _cardapiosList = {'cardapio': '', 'cardapios': []};

  Future<void> _getCardapio() async {
  final paciente = _nameController.text.trimRight().trimLeft();
  
  final paciendeBd = await DatabaseService.getLikePacientes(paciente);
  if (paciendeBd.isEmpty) return;
  
  final cardapio = await DatabaseService.getCardapio(paciendeBd[0]['id']);
  final cardapiosAlimento = await DatabaseService.getCardapioAlimento(cardapio[0]['id']);

  // Copie `cardapiosAlimento` para uma lista mutável `cardapiosAlimento2`
  var cardapiosAlimento2 = [];

  for (var i = 0; i < cardapiosAlimento.length; i++) {
    var alimento_id = cardapiosAlimento[i]['alimento_id'];
    var alimento = await DatabaseService.getAlimentoId(alimento_id);
    cardapiosAlimento2.add(alimento[0]);
  }

  setState(() {
    _cardapiosList = {
      'cardapio': cardapio[0]['nome'],
      'cardapios': cardapiosAlimento2, 
    };
  });
  print(_cardapiosList);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Cardápio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _nameController,
              hintText: 'Nome do Paciente',
              obscureText: false,
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {
                _getCardapio();
              },
              text: 'Buscar Cardápio',
            ),
            const SizedBox(height: 16),
            CustomListView(options: _cardapiosList, title: "Cardápios"),
          ],
        ),  
      )
    );
  }
}