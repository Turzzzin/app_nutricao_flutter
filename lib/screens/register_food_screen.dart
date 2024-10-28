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
    Map<String, dynamic> usuario = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Alimento"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: fotoPathController,
              decoration: InputDecoration(
                labelText: "Foto Path",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: categoriaController,
              decoration: InputDecoration(
                labelText: "Categoria",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: tipoController,
              decoration: InputDecoration(
                labelText: "Tipo",
                border: OutlineInputBorder(),
              ),
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
          ],
        ),
      ),
    );
  }
}