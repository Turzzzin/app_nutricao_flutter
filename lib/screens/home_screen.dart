import 'package:flutter/material.dart';
import '../utils/custom_appbar.dart'; // Adjust the path if necessary
import '../utils/database_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> usuario = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.white, // Light green background color
      appBar: CustomAppBar(
        title: 'Tela Principal',
        textColor: Colors.black, // Set the desired text color here
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Add refresh functionality here
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
                    Navigator.pushNamed(context, '/alimento/novo', arguments: usuario);
                  },
                ),
                _buildMenuButton(
                  icon: Icons.person_add_outlined,
                  label: 'CADASTRAR\nPACIENTE',
                  onPressed: () {
                    // Add cadastrar paciente functionality
                  },
                ),
                _buildMenuButton(
                  icon: Icons.article_outlined,
                  label: 'NOVO\nCARDÁPIO',
                  onPressed: () {
                    // Add novo cardápio functionality
                  },
                ),
              ],
            ),
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
