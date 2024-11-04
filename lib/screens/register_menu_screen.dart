import 'dart:io';

import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/database_service.dart';
import '../utils/auth_check.dart';
import '../utils/custom_error_dialog.dart';
import '../utils/custom_success_dialog.dart';
import '../utils/get_photo.dart';
import '../utils/custom_dropdown.dart';


class RegisterMenuScreen extends StatefulWidget {
  const RegisterMenuScreen({Key? key}) : super(key: key);

  @override
  State<RegisterMenuScreen> createState() => _RegisterMenuScreenState();
}


class _RegisterMenuScreenState extends State<RegisterMenuScreen> {
  @override
  void initState() {
    super.initState();
    _listAlimentos(); // Chama a função desejada ao carregar a tela
  }

  final _nameController = TextEditingController();

  
  Map<String, dynamic>? usuario = {};
  final opcoes = [
    {'id': 1, 'nome': 'Almoço'},
    {'id': 2, 'nome': 'Café da manhã'},
    {'id': 3, 'nome': 'Jantar'},
  ];
  int? cardapioId;
  var cardapiosList = [];
  List<Map<String, dynamic>> alimentosList = [];
  List<int> alimentosIdList = [];
  int? _selectedId;


  Future<int> _cadastrarCardapio() async {
    setState() async {
      usuario = await AuthCheck().checkLoginStatus();
    }
    final nome = _nameController.text;
    final cardapio = await DatabaseService.cadastrarCardapio(nome, usuario!['id'],0);
    return cardapio;
  }

  Future<void> _listAlimentos() async {
    final alimentos = await DatabaseService.listAlimentos();  
    setState(() {
      alimentosList = alimentos;
    });
  }

  Future<int> _cadastrarAlimento() async {
    final alimentoSelectedId = _selectedId;
    if (cardapioId == null) {
      final cardapio = await _cadastrarCardapio();
      setState(() {
        cardapioId = cardapio;
      });

    }
    return await DatabaseService.cadastrarCardapioAlimento(
      opcao, cardapioId, alimentoSelectedId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Cardapio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _nameController,
              hintText: 'Nome do cardapio',
              obscureText: false,
            ),
            const SizedBox(height: 16),
            Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(children: [
              customDropdown(
              options: alimentosList,
              selectedId: _selectedId,
              onChanged: (int? newId) {
                setState(() {
                  _selectedId = newId;
                });
              },
              text: 'Selecione um alimento',
              ),
              CustomButton(
                onPressed: () async {
                  await _cadastrarAlimento();
                },
                text: "${const Icon(Icons.add)}")
            ],)
            ],
            ),
          )]
        ),
      )
  );
  }
      
}