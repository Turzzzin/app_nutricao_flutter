package com.example.app_nutricao_flutter

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.app/ShareFile"  // Definindo um canal de comunicação com o Flutter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Método chamado quando o Flutter chama o canal
        MethodChannel(flutterEngine!!.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "shareFile") {
                val filePath = call.argument<String>("filePath")  // Recupera o caminho do arquivo passado
                if (filePath != null) {
                    shareFile(filePath)
                    result.success("Arquivo compartilhado com sucesso")
                } else {
                    result.error("UNAVAILABLE", "Caminho do arquivo não disponível", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    // Função de compartilhamento de arquivo
    private fun shareFile(filePath: String) {
        val file = File(filePath)
        val uri: Uri = FileProvider.getUriForFile(this, "${packageName}.fileprovider", file)
        
        val intent = Intent(Intent.ACTION_SEND).apply {
            type = "application/pdf" // Ou o tipo do arquivo
            putExtra(Intent.EXTRA_STREAM, uri)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)  // Permissões para acessar o arquivo
        }
        
        startActivity(Intent.createChooser(intent, "Compartilhar arquivo"))
    }
}
