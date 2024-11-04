import 'dart:io';

import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/database_service.dart';
import '../utils/auth_check.dart';
import '../utils/custom_error_dialog.dart';
import '../utils/custom_success_dialog.dart';
import '../utils/get_photo.dart';


class RegisterFoodScreen extends StatefulWidget {
  @override
  _RegisterFoodScreen createState() => _RegisterFoodScreen();
}


class _RegisterFoodScreen extends State<RegisterFoodScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController usuarioIdController = TextEditingController();

  File? _selectedImage;
  String photoPathF = "";




  Future <int> _cadastrarAlimento(usuario) async {
    final nome = nomeController.text;
    final fotoPath = photoPathF;
    final categoria = categoriaController.text;
    final tipo = tipoController.text;
    final user = await DatabaseService.getUsuario(usuario['username']);
    final usuarioId = user[0]['id'];
    return await DatabaseService.cadastrarAlimento(nome, fotoPath, categoria, tipo, usuarioId); 
  }
  Future<Map<dynamic, dynamic>?> getUsername() async {
    return await AuthCheck().checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Alimento"),
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
              controller: categoriaController,
              hintText: 'Categoria',
              obscureText: false,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: tipoController,
              hintText: "Tipo",
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
              text: 'Selecionar foto alimento',
            ),
            SizedBox(height: 32),
            CustomButton(
                onPressed: () async {
                  final usuario  = await AuthCheck().checkLoginStatus();
                  if (usuario != null) {
                    await _cadastrarAlimento(usuario);
                    showSuccessDialog(context, 'Alimento cadastrado com sucesso!', '/home');
                  }
                  else {
                    showErrorDialog(context, 'Usuário não encontrado');
                  }
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