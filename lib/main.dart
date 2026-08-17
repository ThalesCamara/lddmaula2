import 'package:flutter/material.dart';

void main() => runApp(const DiarioApp());

class Habito {
  final String nome;
  final String meta;
  final IconData icone;

  const Habito(this.nome, this.meta, this.icone);
}

const habitos = [
  Habito('Academia', 'Meta: 1 hora e meia por dia', Icons.fitness_center),
  Habito('Futebol', 'Meta: 2 partidas por semana', Icons.sports_soccer),
  Habito('Estudar', 'Meta: 1 hora por dia', Icons.school),
  Habito('Ler', 'Meta: 30 minutos por dia', Icons.menu_book),
];

class DiarioApp extends StatelessWidget {
  const DiarioApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Diário de Hábitos',
    home: Scaffold(
      appBar: AppBar(title: const Text('Meus Hábitos')),
      body: ListView(
        children: [
          for (final h in habitos)
            ListTile(
              leading: Icon(h.icone),
              title: Text(h.nome),
              subtitle: Text(h.meta),
            ),
        ],
      ),
    ),
  );
}