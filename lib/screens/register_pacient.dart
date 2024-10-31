import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/database_service.dart';
import '../utils/auth_check.dart';
import '../utils/custom_error_dialog.dart';
import '../utils/custom_success_dialog.dart';


class RegisterPacient extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController fotoPathController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  
  RegisterPacient({super.key});

  Future<int> _cadastrarPaciente() async {
    final nome = nomeController.text;
    final sobrenome = sobrenomeController.text;
    final fotoPath = fotoPathController.text;
    return await DatabaseService.cadastrarPaciente(nome, sobrenome, fotoPath);
  }

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
              obscureText: true,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: fotoPathController,
              hintText: 'Foto',
              obscureText: true,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}