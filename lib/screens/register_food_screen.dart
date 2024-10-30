import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/database_service.dart';



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

  @override
  Widget build(BuildContext context) {
    String usuario = ModalRoute.of(context)!.settings.arguments as String;
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
                  await _cadastrarAlimento(usuario);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Sucesso!'),
                          content: const Text('Alimento cadastrado com sucesso!'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pushNamed(context, '/home', arguments: usuario);
                              },
                            ),
                          ],
                        );
                      });
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