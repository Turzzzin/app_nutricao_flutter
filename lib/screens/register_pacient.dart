import 'dart:io';

import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/database_service.dart';
import '../utils/custom_success_dialog.dart';
import '../utils/get_photo.dart';


class RegisterPacientScreen extends StatefulWidget {

  @override
  _RegisterPacientScreen createState() => _RegisterPacientScreen();
}

  class _RegisterPacientScreen extends State<RegisterPacientScreen> {
  
  
  File? _selectedImage;
  String photoPathF = "";

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController fotoPathController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  

  Future<int> _cadastrarPaciente() async {
    final nome = nomeController.text;
    final sobrenome = sobrenomeController.text;
    final fotoPath = fotoPathController.text;
    return await DatabaseService.cadastrarPaciente(nome, sobrenome, fotoPath);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Paciente"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: nomeController,
              hintText: 'Nome',
              obscureText: false,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: sobrenomeController,
              hintText: 'Sobrenome',
              obscureText: false,
            ),
            SizedBox(height: 16),
            _selectedImage != null
                ? Image.file(_selectedImage!, width: 100, height: 100) // Exibe a imagem selecionada
                : Text("Nenhuma imagem selecionada"),
            SizedBox(height: 16),
            CustomButton(
              onPressed: () async {
                photoPathF = await getPhoto();
                setState(() {
                  _selectedImage = File(photoPathF);
                });
              },
              text: 'Selecionar foto paciente',
            ),
            SizedBox(height: 32),
            CustomButton(
                onPressed: () async {
                    await _cadastrarPaciente();
                    showSuccessDialog(context, 'Paciente cadastrado com sucesso!', '/home');
                },
                text: "Cadastrar",
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}