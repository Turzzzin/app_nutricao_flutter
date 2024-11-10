import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Informação do grupo"),
        backgroundColor: const Color(0xFF98EDC3)
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Integrantes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 24.0),
              Text(
                'Artur Fagundes Guimarães',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('artur.guimaraes01@fatec.sp.gov.br'),
              SizedBox(height: 16),
              Text(
                'Felipe Monteiro de Faria',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('felipe.faria5@fatec.sp.gov.br'),
              SizedBox(height: 16),
              Text(
                'Wellington Yago Gouvea',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('wellington.gouvea@fatec.sp.gov.br'),
              SizedBox(height: 16),
              Text(
                'Vitor Costansi do Nascimento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('vitor.nascimento12@fatec.sp.gov.br'),
            ],
          ),
        ),
      ),
    );
  }
}
