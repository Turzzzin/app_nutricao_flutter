import 'package:flutter/material.dart';
import '../utils/custom_button.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io'; 
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';


class ShareScreenPDF extends StatelessWidget {
  final Map<dynamic, dynamic> item;
  final String opcao;

  const ShareScreenPDF({
    Key? key,
    required this.item,
    required this.opcao
  }) : super(key: key);


  Future<pw.Widget> buildImage(String imagePath) async {
  final file = File(imagePath);
  final imageBytes = await file.readAsBytes();
  final image = pw.MemoryImage(imageBytes);
  
  return pw.Image(image, width: 100, height: 100);
}

  
  Future<void> shareFile(String filePath) async {
    try {
      final File file = File(filePath);
      if (await file.exists()) {
        await Share.shareXFiles([XFile(filePath)], text: 'Compartilhar PDF');
      } else {
        throw Exception('Arquivo não encontrado');
      }
    } catch (e) {
      print('Erro ao compartilhar PDF: $e');
      rethrow;
    }
  }

  // Função para gerar o PDF
  Future<void> generatePDF(Map<dynamic, dynamic> item, String opcao) async {
    // Criação do documento PDF
    final pdf = pw.Document();
    
    String texto = '';
    for(var key in item.keys) {
      if (key == 'fotoPath' || key == 'id' || key == 'createdAt' || key == 'usuario_id') continue;
      texto += '$key: ${item[key]}\n';
    }
    final image = await buildImage(item['fotoPath']);
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
                  child: image,
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
    
    // Criação do caminho para salvar o PDF
    final outputDirectory = await getApplicationDocumentsDirectory();
    final outputPath = '${outputDirectory.path}/$opcao.pdf';

    // Salve o PDF no caminho especificado
    final file = File(outputPath);
    await file.writeAsBytes(await pdf.save());

    // Exibir o caminho do arquivo gerado
    print(outputPath);
    shareFile(outputPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compartilhar PDF'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(item['nome'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {
                generatePDF(item, opcao);
              },
              text: 'Gerar PDF',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

