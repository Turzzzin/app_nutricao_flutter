// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/custom_appbar.dart';
import '../utils/database_service.dart'; 

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignupScreen({Key? key}) : super(key: key);


  Future <bool> _criarUsuario() async {
    String email = emailController.text;
    String password = passwordController.text;
    
    final usuario = await DatabaseService.getUsuario(email);
    if (usuario.isNotEmpty) {
      return false;
    }
    await DatabaseService.cadastrarUsuario(email, password);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF98EDC3),
      appBar: const CustomAppBar(
        title: 'Cadastrar',
        textColor: Colors.black, // Set the desired text color here
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'E-MAIL',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: emailController,
                hintText: 'exemplo@gmail.com',
              ),
              const SizedBox(height: 16),
              const Text(
                'SENHA',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: passwordController,
                hintText: 'senha',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              const Text(
                'CONFIRMAR SENHA',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'CONFIRMAR senha',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () async {
                  // Adicione a lógica para registrar o usuário aqui
                  // Por exemplo, verificar se as senhas correspondem e chamar a API de registro
                  bool _criado = false;
                  bool _senhaIgual = false;
                  if (passwordController.text == confirmPasswordController.text) {
                    _criado = await _criarUsuario();
                    _senhaIgual = true;
                  }
                  else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erro'),
                          content: const Text('As senhas informadas não correspondem.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (_criado) {
                    Navigator.pushNamed(context, '/login');
                  }
                  else if (!_criado && _senhaIgual) {
                    showDialog( 
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erro'),
                          content: const Text('Usuário já existe.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                text: 'CADASTRAR',
              ),
            ],
          ),
        ),
      )
      ),
    );
  }
}
