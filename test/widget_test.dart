import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_flutter_habitos/dados/habitos_repositorio.dart';
import 'package:teste_flutter_habitos/dados/preferencias_repositorio.dart';
import 'package:teste_flutter_habitos/dominio/habito.dart';
import 'package:teste_flutter_habitos/dominio/habitos_store.dart';
import 'package:teste_flutter_habitos/dominio/preferencias_store.dart';
import 'package:teste_flutter_habitos/main.dart';

class RepositorioTeste extends HabitosRepositorio {
  final List<Habito> lista = [];

  @override
  Future<List<Habito>> carregar() async => List.of(lista);

  @override
  Future<void> salvar(Habito habito) async => lista.add(habito);
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('Tema padrão e preferência restaurada em uma nova loja', () async {
    final repo = PreferenciasRepositorio();
    expect(await repo.lerTema(), isFalse);
    final loja = PreferenciasStore(repo, await repo.lerTema());
    await loja.alternarTema();
    final novaLoja = PreferenciasStore(
      PreferenciasRepositorio(),
      await PreferenciasRepositorio().lerTema(),
    );
    expect(novaLoja.temaEscuro, isTrue);
    await novaLoja.alternarTema();
    expect(await repo.lerTema(), isFalse);
    loja.dispose();
    novaLoja.dispose();
  });

  testWidgets('Cadastro, resumo e botão de tema funcionam', (tester) async {
    final repositorio = RepositorioTeste();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HabitosStore(repositorio)..carregar(),
          ),
          ChangeNotifierProvider(
            create: (_) => PreferenciasStore(PreferenciasRepositorio(), false),
          ),
        ],
        child: const DiarioApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Perfil'), findsNothing);
    await tester.tap(find.byTooltip('Usar tema escuro'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
    expect(await PreferenciasRepositorio().lerTema(), isTrue);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Caminhar');
    await tester.enterText(find.byType(TextFormField).at(1), '30 minutos');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Caminhar'), findsOneWidget);
    await tester.tap(find.text('Resumo'));
    await tester.pumpAndSettle();
    expect(find.text('1 hábitos cadastrados'), findsOneWidget);
  });
}
