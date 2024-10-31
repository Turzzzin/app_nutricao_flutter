import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/database_service.dart';
import '../utils/auth_check.dart';
import '../utils/custom_error_dialog.dart';
import '../utils/custom_success_dialog.dart';



class RegisterFoodScreen extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController fotoPathController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController usuarioIdController = TextEditingController();

  RegisterFoodScreen({super.key});

  Future <int> _cadastrarAlimento(usuario) async {
    final nome = nomeController.text;
    final fotoPath = fotoPathController.text;
    final categoria = categoriaController.text;
    final tipo = tipoController.text;
    final usuarioId = usuario['id'];
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
              obscureText: true,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: fotoPathController,
              hintText: 'Foto',
              obscureText: true,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: categoriaController,
              hintText: 'Categoria',
              obscureText: true,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: tipoController,
              hintText: "Tipo",
              obscureText: true,
            ),
            SizedBox(height: 32),
            CustomButton(
                onPressed: () async {
                  final usuario  = await getUsername();
                  if (usuario != null) {
                    await _cadastrarAlimento(usuario['username']);
                    showSuccessDialog(context, 'Alimento cadastrado com sucesso!');
                  }
                  else {
                    showErrorDialog(context, 'Usuário não encontrado');
                  }
                  Navigator.pushNamed(context, '/home');
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