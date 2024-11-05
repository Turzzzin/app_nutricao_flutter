import 'package:flutter/material.dart';
import 'custom_dropdown.dart';
import 'custom_button.dart';



class CustomBox extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> options;
  final int? selectedId;
  final ValueChanged<int?> onChanged;
  final VoidCallback onPressed;
  final String text;
  List<Map<String, dynamic>> alimentosSelectedList = [];
  var indice = 0;

  CustomBox({
    Key? key,
    required this.title,
    required this.options,
    required this.selectedId,
    required this.text,
    required this.onChanged,
    required this.onPressed,
    required this.alimentosSelectedList,
    required this.indice,
  }) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.start, // Alinha o título à esquerda
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                // Expande o dropdown para ocupar o máximo de espaço disponível
                child: customDropdown(
                  options: options,
                  selectedId: selectedId,
                  onChanged: onChanged,
                  text: title,
                ),
              ),
            ],
          ),
           SizedBox(width: 16),
           Align(
             alignment: Alignment.centerRight,
             child: CustomButton(
            text: "Adicionar",
            onPressed: onPressed,
          ),
          ),
          alimentosSelectedList.isEmpty
            ? Text("Nenhum item selecionado") // Mostra mensagem se a lista estiver vazia
            :
            ListView.builder(
            shrinkWrap: true, // Garante que o ListView ocupe apenas o espaço necessário
            physics: const NeverScrollableScrollPhysics(),
            itemCount: alimentosSelectedList.length,
            itemBuilder: (context, index) {
              final item = alimentosSelectedList[index];
              return ListTile(
                leading: CircleAvatar(child: Text((index+1).toString())),
                title: Text(item['nome']),
                subtitle: Text(item['categoria']),
                onTap: () {
                  print('Item selecionado: ${item['nome']}');
                },
              );
            },
            ), 

        ],
      ),
    );
  }
}