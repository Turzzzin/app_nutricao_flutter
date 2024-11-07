import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io'; // Para manipulação de arquivos
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

class ShareScreen extends StatefulWidget {
  final Map<dynamic, dynamic>? item;
  final String? opcao;

  const ShareScreen({this.item, this.opcao, super.key});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  static const MethodChannel _channel = MethodChannel('com.example.app/ShareFile');
  bool _isLoading = false; // Estado para mostrar carregamento

  // Função para compartilhar o arquivo
  Future<void> shareFile(String filePath) async {
    try {
      final String result = await _channel.invokeMethod('shareFile', {'filePath': filePath});
      print(result); // Sucesso no compartilhamento
    } on PlatformException catch (e) {
      print("Erro ao compartilhar o arquivo: ${e.message}");
    }
  }

  // Função para gerar o PDF
  Future<void> generatePDF(Map<dynamic, dynamic> item, String opcao) async {
    setState(() {
      _isLoading = true; // Inicia o carregamento
    });

    // Criação do documento PDF
    final pdf = pw.Document();
    String texto = '';
    final data = item.remove('fotoPath');
    data.forEach((key, value) {
      texto += '$key: $value\n';
    });

    // Verifica se a foto existe antes de tentar adicionar ao PDF
    final String? fotoPath = item['fotoPath'];
    if (fotoPath != null && File(fotoPath).existsSync()) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Stack(
              children: [
                // Posiciona a imagem no canto superior esquerdo
                pw.Positioned(
                  top: 0,
                  left: 0,
                  child: pw.Image(item['fotoPath'], width: 100, height: 100),
                ),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(texto),
                ),
              ],
            );
          },
        ),
      );
    } else {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text(texto),
            );
          },
        ),
      );
    }

    final outputDirectory = await getApplicationDocumentsDirectory();
    final outputPath = '${outputDirectory.path}/$opcao.pdf';

    // Salve o PDF no caminho especificado
    final file = File(outputPath);
    await file.writeAsBytes(await pdf.save());

    // Exibir o caminho do arquivo gerado
    setState(() {
      _isLoading = false; // Finaliza o carregamento
    });

    shareFile(outputPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compartilhar Arquivo')),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Mostra indicador de carregamento
            : IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  generatePDF(widget.item ?? {}, widget.opcao ?? 'default');
                },
              ),
      ),
    );
  }
}
