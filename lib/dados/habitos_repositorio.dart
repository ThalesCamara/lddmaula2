import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../dominio/habito.dart';

class HabitosRepositorio {
  Future<Database> _abrir() async => openDatabase(
    join(await getDatabasesPath(), 'habitos.db'),
    version: 1,
    onCreate: (db, _) async {
      await db.execute(
        'CREATE TABLE habitos('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'nome TEXT NOT NULL, '
        'meta TEXT NOT NULL, '
        'tipo_icone TEXT NOT NULL)',
      );
      const exemplos = [
        Habito(
          nome: 'Academia',
          meta: 'Meta: 1 hora e meia por dia',
          tipoIcone: TipoIconeHabito.academia,
        ),
        Habito(
          nome: 'Futebol',
          meta: 'Meta: 2 partidas por semana',
          tipoIcone: TipoIconeHabito.esporte,
        ),
        Habito(
          nome: 'Estudar',
          meta: 'Meta: 1 hora por dia',
          tipoIcone: TipoIconeHabito.estudo,
        ),
        Habito(
          nome: 'Ler',
          meta: 'Meta: 30 minutos por dia',
          tipoIcone: TipoIconeHabito.leitura,
        ),
      ];
      for (final habito in exemplos) {
        await db.insert('habitos', habito.toMap());
      }
    },
  );

  Future<List<Habito>> carregar() async {
    final db = await _abrir();
    final linhas = await db.query('habitos', orderBy: 'id ASC');
    return linhas.map(Habito.fromMap).toList();
  }

  Future<void> salvar(Habito habito) async {
    final db = await _abrir();
    await db.insert('habitos', habito.toMap());
  }

  Future<void> atualizar(Habito habito) async {
    if (habito.id == null) {
      throw ArgumentError('O hábito precisa de um id para ser atualizado.');
    }
    final db = await _abrir();
    await db.update(
      'habitos',
      habito.toMap(),
      where: 'id = ?',
      whereArgs: [habito.id],
    );
  }

  Future<void> apagar(int id) async {
    final db = await _abrir();
    await db.delete('habitos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> remover(Habito habito) async {
    final id = habito.id;
    if (id == null) {
      throw ArgumentError('O hábito precisa de um id para ser removido.');
    }
    await apagar(id);
  }
}
