import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart'; // Para obter o caminho do diretório
import 'dart:io'; // Para manipulação de arquivos
import 'package:pdf/widgets.dart' as pw;


class ShareScreen extends StatelessWidget {
  final Map<dynamic, dynamic>? item;
  final String? opcao;

  const ShareScreen({this.item, this.opcao, super.key});
  
  // Função que pega o caminho do arquivo e compartilha
  Future<void> shareFile(item, opcao) async {
    
    
    
    final pdfPath = await generatePDF(item, opcao);
    // Verifique se o arquivo existe no caminho fornecido
    final file = File(pdfPath);
    if (file.existsSync()) {
      // Compartilhe o arquivo
      Share.shareXFiles([XFile(pdfPath)], text: 'Aqui está o meu $opcao!');
    } else {
      print('Arquivo não encontrado!');
    }
  }

  Future<String> generatePDF(item, opcao) async {
    // Criação do documento PDF
    final pdf = pw.Document();
    String texto = '';
    final data = item.remove('fotoPath');
    data.forEach((key, value) {
      texto += '$key: $value\n';
    });

    // Adicionar conteúdo ao PDF
    pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            // Posiciona a imagem no canto superior esquerdo
            pw.Positioned(
              top: 0,
              left: 0,
              child: pw.Image(item['fotoPath'], width: 100, height: 100), // Ajuste o tamanho conforme necessário
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
    final outputDirectory = await getApplicationDocumentsDirectory();
    final outputPath = '${outputDirectory.path}/$opcao.pdf';

    // Salve o PDF no caminho especificado
    final file = File(outputPath);
    await file.writeAsBytes(await pdf.save());

    // Exibir o caminho do arquivo gerado
    return outputPath;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compartilhar Arquivo')),
      body: Center(
        
        child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  shareFile(item, opcao);
                },
        ),
      ),
    );
  }
}