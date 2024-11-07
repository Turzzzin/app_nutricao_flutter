import 'package:flutter/material.dart';
import '../screens/share_screen.dart';

class ShareScreen extends StatefulWidget {
  final Map<dynamic, dynamic>? item;
  final String? opcao;

  const ShareScreen({this.item, this.opcao, super.key});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  

  @override
  Widget build(BuildContext context) {
  return IconButton(
        icon: Icon(Icons.description),
        onPressed: () {
          Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => ShareScreenPDF(item: widget.item ?? {}, opcao: widget.opcao ?? ''),
              ),);
        },
      );
}
}
