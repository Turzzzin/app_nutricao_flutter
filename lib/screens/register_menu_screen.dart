import 'package:flutter/material.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/database_service.dart';
import '../utils/auth_check.dart';
import '../utils/custom_box.dart';


class RegisterMenuScreen extends StatefulWidget {
  const RegisterMenuScreen({Key? key}) : super(key: key);

  @override
  State<RegisterMenuScreen> createState() => _RegisterMenuScreenState();
}


class _RegisterMenuScreenState extends State<RegisterMenuScreen> {
  @override
  void initState() {
    super.initState();
    _listAlimentos();
    _listPacientes();
  }

  final _nameController = TextEditingController();

  
  Map<String, dynamic> usuario = {};
  final opcoes = [
    'Almoço',
    'Café da manhã',
    'Jantar',
  ];
  int? cardapioId;
  var cardapiosList = [];
  List<Map<String, dynamic>> alimentosList = [];
  List<Map<String, dynamic>> alimentosCafeSelectedList = [];
  List<Map<String, dynamic>> alimentosAlmocoSelectedList = [];
  List<Map<String, dynamic>> alimentosJantarSelectedList = [];
  List<Map<String, dynamic>> pacientesList = [];
  int? _selectedId;
  int? _selectedPacienteId;
  int indiceC = 0;
  int indiceA = 0;
  int indiceJ = 0;


  Future<int> _cadastrarCardapio() async {
    final loged = await AuthCheck().checkLoginStatus();
    final user = await DatabaseService.getUsuario(loged!['username']);

    setState() {
      usuario = user[0];
    }
    final nome = _nameController.text;
    final cardapio = await DatabaseService.cadastrarCardapio(nome, _selectedPacienteId!);
    return cardapio;
  }

  Future<void> _listAlimentos() async {
    final alimentos = await DatabaseService.listAlimentos();  
    setState(() {
      alimentosList = alimentos;
    });
  }

  Future<void> _listPacientes() async {
    final pacientes = await DatabaseService.listPacientes();
    setState(() {
      pacientesList = pacientes;
    });
  }

  Future<int> _cadastrarAlimento(option) async {
    final alimentoSelectedId = _selectedId;
    if (cardapioId == null) {
      final cardapio = await _cadastrarCardapio();
      setState(() {
        cardapioId = cardapio;
      });

    }
    final opcao = opcoes[option];
    final alimento = alimentosList.firstWhere(
    (item) => item['id'] == alimentoSelectedId,
    orElse: () => {},);
    setState(() {
      if (opcao == 'Café da manhã') { 
        alimentosCafeSelectedList.add(alimento);
        indiceC += 1;
      }
      else if (opcao == 'Almoço') {
        alimentosAlmocoSelectedList.add(alimento);
        indiceA += 1;
      }
      else {
        alimentosJantarSelectedList.add(alimento);
        indiceJ += 1;
      }
    });
    
    return await DatabaseService.cadastrarCardapioAlimento(
      opcao, cardapioId!, alimentoSelectedId!,
    );
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
              hintText: 'Nome do cardapio',
              obscureText: false,
            ),
            const SizedBox(height: 16),
            _selectedPacienteId != null ? Text("Paciente selecionado: ${pacientesList.firstWhere((item) => item['id'] == _selectedPacienteId)['nome']}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,) 
            :
            CustomBox(title: "Paciente", options: pacientesList, selectedId: _selectedPacienteId, text: "Escolha o Paciente", alimentosSelectedList: alimentosAlmocoSelectedList, indice: indiceC,
            onChanged: (int? newId) {
              setState(() {         
              _selectedPacienteId = newId;
              });
            },
            onPressed: () {
               setState(() {
                _selectedPacienteId = _selectedPacienteId;
            }); 
            },
            ),
            const SizedBox(height: 16),
            CustomBox(title: "Café da manhã", options: alimentosList, selectedId: _selectedId, text: "Escolha o Alimento", alimentosSelectedList: alimentosCafeSelectedList, indice: indiceC,
            onChanged: (int? newId) {
              setState(() {
                _selectedId = newId;
            }); 
            },
            onPressed: () async {
              _selectedId = _selectedId;
              await _cadastrarAlimento(1);
            },
            ),
            const SizedBox(height: 16),
            CustomBox(title: "Almoço", options: alimentosList, selectedId: _selectedId, text: "Escolha o Alimento", alimentosSelectedList: alimentosAlmocoSelectedList, indice: indiceA,
            onChanged: (int? newId) {
              setState(() {
                _selectedId = newId;
            }); 
            },
            onPressed: () async {
              _selectedId = _selectedId;
              await _cadastrarAlimento(0);
            },
            ),
            const SizedBox(height: 16),
            CustomBox(title: "Jantar", options: alimentosList, selectedId: _selectedId, text: "Escolha o Alimento", alimentosSelectedList: alimentosJantarSelectedList, indice: indiceJ,
            onChanged: (int? newId) {
              setState(() {
                _selectedId = newId;
            }); 
            },
            onPressed: () async {
              _selectedId = _selectedId;
              await _cadastrarAlimento(2);
            },
            ),
            const SizedBox(height: 16),
            CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            }, 
            text: "Salvar Cardápio"),
          ],
        ),
      ),  
    );
  }
      
}