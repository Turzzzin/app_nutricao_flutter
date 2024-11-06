import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/custom_list_view.dart';
import '../utils/database_service.dart';


class SearchPacientScreen extends StatefulWidget {
  const SearchPacientScreen({super.key});

  @override
  State<SearchPacientScreen> createState() => _SearchPacientScreen();
}

class _SearchPacientScreen extends State<SearchPacientScreen> {
  final _nameController = TextEditingController();
  List<Map<String, dynamic>> _pacientesList = [];

  Future<void> _getPacientes() async {
    final paciente = _nameController.text;
    final pacientes = await DatabaseService.getLikePacientes(paciente);

    setState(() {
      _pacientesList = pacientes;
      print(_pacientesList);
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
              hintText: 'Nome do Paciente',
              obscureText: false,
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {
                _getPacientes();
              },
              text: 'Buscar Paciente',
            ),
            const SizedBox(height: 16),
            CustomListView(options: _pacientesList, title: "Pacientes"),
          ],
        ),
      ),
    );  
  }
}