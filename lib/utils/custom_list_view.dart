import 'package:flutter/material.dart';
import 'dart:io';


class CustomListView extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> options;


  CustomListView({required this.title, required this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 16),
          options.isEmpty
            ? Text("Nenhum Paciente encontrado") 
            :
            ListView.builder(
            shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final item = options[index];
              final fotoPath = item['fotoPath'];
              return ListTile(
                leading: fotoPath != null && File(fotoPath).existsSync()
                ? Image.file(
                    File(fotoPath),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                title: Text(item['nome'] + ' ' + item['sobrenome']),
                subtitle: Text(
                            'Idade: ' +
                            (item['dataNascimento'] != null 
                              ? (DateTime.now().year - DateTime.fromMillisecondsSinceEpoch(item['dataNascimento']).year).toString() + ' anos'
                              : 'Não informado'),
                          ),
                onTap: () {
                  print('Item selecionado: ${item['nome']}');
                },
              );
            },
            ), 
        ]
      ),
    );
  }
}