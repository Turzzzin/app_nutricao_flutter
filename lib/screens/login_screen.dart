import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF98EDC3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20), // Add some top padding
                Center(
                  child: Container(
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
                ),
                const SizedBox(height: 30), // Reduced spacing
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
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.black),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Não tem uma conta ainda?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  text: 'CADASTRAR',
                ),
                const SizedBox(height: 20), // Add bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}