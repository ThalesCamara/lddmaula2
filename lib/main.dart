import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dados/habitos_repositorio.dart';
import 'dominio/habitos_store.dart';
import 'ui/tela_novo_habito.dart';
import 'ui/tela_principal.dart';

void main() {
  final repositorio = HabitosRepositorio();

  runApp(
    ChangeNotifierProvider<HabitosStore>(
      create: (_) => HabitosStore(repositorio)..carregar(),

      child: const DiarioApp(),
    ),
  );
}

class DiarioApp extends StatelessWidget {
  const DiarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Hábitos',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Colors.blue),

      initialRoute: '/',

      routes: {
        '/': (context) => const TelaPrincipal(),

        '/novo': (context) => const TelaNovoHabito(),
      },
    );
  }
}
