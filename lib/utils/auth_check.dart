import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart'; 
import 'package:shared_preferences/shared_preferences.dart';


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
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}