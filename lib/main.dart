import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dados/habitos_repositorio.dart';
import 'dados/preferencias_repositorio.dart';
import 'dominio/habitos_store.dart';
import 'dominio/preferencias_store.dart';
import 'ui/tela_novo_habito.dart';
import 'ui/tela_principal.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repositorio = HabitosRepositorio();
  final preferencias = PreferenciasRepositorio();
  final temaEscuro = await preferencias.lerTema();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HabitosStore>(
          create: (_) => HabitosStore(repositorio)..carregar(),
        ),
        ChangeNotifierProvider<PreferenciasStore>(
          create: (_) => PreferenciasStore(preferencias, temaEscuro),
        ),
      ],
      child: const DiarioApp(),
    ),
  );
}

class DiarioApp extends StatelessWidget {
  const DiarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final temaEscuro = context.watch<PreferenciasStore>().temaEscuro;
    return MaterialApp(
      title: 'Diário de Hábitos',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: temaEscuro ? ThemeMode.dark : ThemeMode.light,

      initialRoute: '/',

      routes: {
        '/': (context) => const TelaPrincipal(),

        '/novo': (context) => const TelaNovoHabito(),
      },
    );
  }
}
