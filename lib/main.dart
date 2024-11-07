import 'package:flutter/material.dart';
import './screens/login_screen.dart'; // Import your login screen here.
import './screens/home_screen.dart'; // Make sure to import home screen too.
import './screens/signup_screen.dart';
import './screens/register_food_screen.dart';
import '../utils/auth_check.dart';
import '../screens/register_pacient.dart';
import '../screens/register_menu_screen.dart';
import '../screens/search_pacient_screen.dart';
import '../screens/search_food_screen.dart';
import '../screens/search_menu_screen.dart';

void main() {
  runApp(MyApp());
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
        '/alimento/buscar': (context) => SearchFoodScreen(),
        '/paciente/novo': (context) => RegisterPacientScreen(),
        '/paciente/buscar': (context) => SearchPacientScreen(),
        '/cardapio/novo': (context) => RegisterMenuScreen(),
        '/cardapio/buscar': (context) => SearchMenuScreen(),
      },
    );
  }
}
