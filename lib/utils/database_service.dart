import 'package:sqflite/sqflite.dart' as sql;

class DatabaseService {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS usuario (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        email TEXT,
        senha TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE IF NOT EXISTS paciente (
      id INTEGER PRIMART KEY AUTOINCREMENT NOT NULL,
      nome TEXT,
      sobrenome TEXT,
      fotoPath TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    )""");

    await database.execute("""CREATE TABLE IF NOT EXISTS alimento
    id INTEGER PRIMART KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    fotoPath TEXT,
    categoria TEXT,
    tipo TEXT,
    FOREIGN KEY (usuario_id) REFERENCES users (id),
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    """);

    await database.execute("""CREATE TABLE IF NOT EXISTS cardapio
    id INTEGER PRIMART KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    FOREIGN KEY (usuario_id) REFERENCES alimento (id),
    FOREIGN KEY (paciente_id) REFERENCES paciente (id),""");

  await database.execute("""CREATE TABLE IF NOT EXISTS cardapio_alimento (
    id INTEGER PRIMART KEY AUTOINCREMENT NOT NULL,
    opcao TEXT,
    FOREIGN KEY (cardapio_id) REFERENCES cardapio (id),
    FOREIGN KEY (alimento_id) REFERENCES alimento (id),
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    """);
  }


  static Future<sql.Database> database() async {
    return sql.openDatabase(
      'nutricao_app.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
}