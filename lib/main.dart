import 'package:app_nutricao_flutter/screens/register_food_screen.dart';
import 'package:flutter/material.dart';
import './screens/login_screen.dart'; // Import your login screen here.
import './screens/home_screen.dart'; // Make sure to import home screen too.
import './screens/signup_screen.dart';
import './screens/register_food_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => SignupScreen(),
        '/alimento/novo': (context) => RegisterFoodScreen(),
      },
    );
  }
}
