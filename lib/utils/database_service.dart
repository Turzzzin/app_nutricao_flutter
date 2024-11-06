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
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nome TEXT,
      sobrenome TEXT,
      fotoPath TEXT,
      dataNascimento TIMESTAMP,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");

  await database.execute("""CREATE TABLE IF NOT EXISTS alimento (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    fotoPath TEXT,
    categoria TEXT,
    tipo TEXT,
    usuario_id INTEGER,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario (id)
  );
""");

    await database.execute("""CREATE TABLE IF NOT EXISTS cardapio (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    paciente_id INTEGER,
    FOREIGN KEY (paciente_id) REFERENCES paciente (id)
  );
""");


  await database.execute("""CREATE TABLE IF NOT EXISTS cardapio_alimento (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    opcao TEXT,
    cardapio_id INTEGER,
    alimento_id INTEGER,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cardapio_id) REFERENCES cardapio (id),
    FOREIGN KEY (alimento_id) REFERENCES alimento (id)
    );
    """);
  }

//cria ou conecta a db
  static Future<sql.Database> database() async {
    return sql.openDatabase(
      'nutricao_app.db',
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute('ALTER TABLE paciente ADD COLUMN dataNascimento TIMESTAMP');
        }
      },
    );
  }

//cadastra usuário
  static Future<int> cadastrarUsuario(String email, String senha) async {
    final db = await database();
    final data = {'email': email, 'senha': senha};
    final id = await db.insert('usuario', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

//busca usuário
  static Future<List<Map<String, dynamic>>> getUsuario(String email)  async {
    final db = await database();
    return db.query('usuario',where: 'email = ?', whereArgs: [email], limit: 1);
  }

//cadastra paciente
  static Future<int> cadastrarPaciente(String nome, String sobrenome, String fotoPath, DateTime dataNascimento) async {
    final db = await database();
    int timestamp = dataNascimento.millisecondsSinceEpoch;
    final data = {'nome': nome, 'sobrenome': sobrenome, 'fotopath': fotoPath, 'dataNascimento': timestamp};
    final id = await db.insert('paciente', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

//busca paciente
  static Future<List<Map<String, dynamic>>> getPaciente(String nome)  async {
    final db = await database();
    return db.query('paciente',where: 'nome = ?', whereArgs: [nome]);
  }

  static Future<List<Map<String, dynamic>>> listPacientes()  async {
    final db = await database();
    return db.query('paciente');
  }
  static Future<List<Map<String, dynamic>>> getLikePacientes(String nome)  async {
    final db = await database();
    return db.query('paciente',where: 'nome LIKE ?', whereArgs: ['%$nome%']);
  }

//cadastra alimento
  static Future<int> cadastrarAlimento(String nome, String fotoPath, String categoria, String tipo, int usuarioId) async {
    final db = await database();
    final data = {'nome': nome, 'fotopath': fotoPath, 'categoria': categoria, 'tipo': tipo, 'usuario_id': usuarioId};
    final id = await db.insert('alimento', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

//busca alimento
  static Future<List<Map<String, dynamic>>> getAlimento(String nome)  async {
    final db = await database();
    return db.query('alimento',where: 'nome = ?', whereArgs: [nome], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> listAlimentos()  async {
    final db = await database();
    return db.query('alimento');
  }

  static Future<List<Map<String, dynamic>>> getLikeAlimentos(String nome)  async {
    final db = await database();
    return db.query('alimento',where: 'nome LIKE ?', whereArgs: ['%$nome%']);
  }

//cadastra cardapio
  static Future<int> cadastrarCardapio(String nome, int pacienteId) async {
    final db = await database();
    final data = {'nome': nome, 'paciente_id': pacienteId};
    final id = await db.insert('cardapio', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

//busca cardapio
  static Future<List<Map<String, dynamic>>> getCardapio(int pacienteId)  async {
    final db = await database();
    return db.query('cardapio',where: 'paciente_id = ?', whereArgs: [pacienteId], limit: 1);
  }

//cadastra cardapio alimento
  static Future<int> cadastrarCardapioAlimento(String opcao, int cardapioId, int alimentoId) async {
    final db = await database();
    final data = {'opcao': opcao, 'cardapio_id': cardapioId, 'alimento_id': alimentoId};
    final id = await db.insert('cardapio_alimento', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

//busca cardapio alimento
  static Future<List<Map<String, dynamic>>> getCardapioAlimento(int cardapioId)  async {
    final db = await database();
    return db.query('cardapio_alimento',where: 'cardapio_id = ?', whereArgs: [cardapioId]);
  }
}