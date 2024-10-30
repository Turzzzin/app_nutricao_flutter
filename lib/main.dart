import 'package:app_nutricao_flutter/screens/register_food_screen.dart';
import 'package:flutter/material.dart';
import './screens/login_screen.dart'; // Import your login screen here.
import './screens/home_screen.dart'; // Make sure to import home screen too.
import './screens/signup_screen.dart';
import './screens/register_food_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class AuthCheck extends StatelessWidget {
  Future<Map<String, dynamic>?> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final username = prefs.getString('username') ?? '';

    if (isLoggedIn) {
      return {'username': username};
    } else {  
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Erro ao verificar o status de login"));
        }
        if (snapshot.data != null) {
          final userData = snapshot.data!;
          return HomeScreen(username: userData['username']); // Passa o usuário
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: AuthCheck(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignupScreen(),
        '/alimento/novo': (context) => RegisterFoodScreen(),
      },
    );
  }
}
