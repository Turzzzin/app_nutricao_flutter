// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
import '../utils/custom_appbar.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF98EDC3),
      appBar: const CustomAppBar(
        title: 'Cadastrar',
        textColor: Colors.black, // Set the desired text color here
      ),
      body: SafeArea(
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
                onPressed: () {
                  // Adicione a lógica para registrar o usuário aqui
                  // Por exemplo, verificar se as senhas correspondem e chamar a API de registro
                  Navigator.pushNamed(context, '/home');
                },
                text: 'CADASTRAR',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
