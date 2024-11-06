import 'package:flutter/material.dart';
import '../utils/custom_appbar.dart'; // Adjust the path if necessary
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({Key? key}) : super(key: key);


  Future<void> logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      await prefs.remove('username'); 
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light green background color
      appBar: CustomAppBar(
        title: 'Tela Principal',
        textColor: Colors.black, // Set the desired text color here
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(
                  icon: Icons.add_circle_outline,
                  label: 'CADASTRAR\nALIMENTO',
                  onPressed: () {
                    Navigator.pushNamed(context, '/alimento/novo');
                  },
                ),
                _buildMenuButton(
                  icon: Icons.person_add_outlined,
                  label: 'CADASTRAR\nPACIENTE',
                  onPressed: () {
                    Navigator.pushNamed(context, '/paciente/novo');
                  },
                ),
                _buildMenuButton(
                  icon: Icons.article_outlined,
                  label: 'NOVO\nCARDÁPIO',
                  onPressed: () {
                    Navigator.pushNamed(context, '/cardapio/novo');
                  },
                ),               
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuButton(
                  icon: Icons.person,
                  label: 'BUSCAR\nPACIENTE',
                  onPressed: () {
                    Navigator.pushNamed(context, '/paciente/buscar');
                  },
                ),
                _buildMenuButton(
                  icon: Icons.person,
                  label: 'BUSCAR\nALIMENTO',
                  onPressed: () {
                    Navigator.pushNamed(context, '/alimento/buscar');
                  },
                ),
                ])
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(icon, size: 30),
              onPressed: onPressed,
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
