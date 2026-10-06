import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:teste_flutter_habitos/dados/habitos_repositorio.dart';
import 'package:teste_flutter_habitos/dominio/habito.dart';

void main() {
  late Directory pasta;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    pasta = await Directory.systemTemp.createTemp('habitos_teste_');
    await databaseFactory.setDatabasesPath(pasta.path);
  });

  tearDown(() async {
    final db = await databaseFactory.openDatabase(
      join(pasta.path, 'habitos.db'),
    );
    await db.close();
    await pasta.delete(recursive: true);
  });

  test('Cadastro e ícone sobrevivem ao fechamento do banco', () async {
    final repo = HabitosRepositorio();
    expect(await repo.carregar(), hasLength(4));
    await repo.salvar(
      const Habito(
        nome: 'Caminhar',
        meta: 'Meta: 30 minutos',
        tipoIcone: TipoIconeHabito.esporte,
      ),
    );
    final db = await databaseFactory.openDatabase(
      join(pasta.path, 'habitos.db'),
    );
    await db.close();

    final restaurados = await HabitosRepositorio().carregar();
    expect(restaurados, hasLength(5));
    final salvo = restaurados.last;
    expect(salvo.id, isNotNull);
    expect(salvo.nome, 'Caminhar');
    expect(salvo.meta, 'Meta: 30 minutos');
    expect(salvo.tipoIcone, TipoIconeHabito.esporte);
  });

  test('Exclusão usa id e não recria exemplos ao reabrir', () async {
    final repo = HabitosRepositorio();
    final exemplos = await repo.carregar();
    for (final habito in exemplos) {
      await repo.remover(habito);
    }
    const repetido = Habito(nome: 'Ler', meta: 'Meta: 10 páginas');
    await repo.salvar(repetido);
    await repo.salvar(repetido);
    final dois = await repo.carregar();
    expect(dois.first.id, isNot(dois.last.id));
    await repo.remover(dois.first);
    final db = await databaseFactory.openDatabase(
      join(pasta.path, 'habitos.db'),
    );
    await db.close();
    final restaurados = await HabitosRepositorio().carregar();
    expect(restaurados, hasLength(1));
    expect(restaurados.single.id, dois.last.id);
  });

  test('Atualização altera somente o registro selecionado', () async {
    final repo = HabitosRepositorio();
    final antes = await repo.carregar();
    await repo.atualizar(
      Habito(
        id: antes.first.id,
        nome: "Academia d'água",
        meta: 'Meta: 20 minutos',
        tipoIcone: TipoIconeHabito.academia,
      ),
    );
    final depois = await repo.carregar();
    expect(depois, hasLength(4));
    expect(depois.first.nome, "Academia d'água");
    expect(depois[1].toMap(), antes[1].toMap());
  });
}
