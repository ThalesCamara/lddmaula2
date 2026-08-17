import 'package:flutter/material.dart';

void main() => runApp(const DiarioApp());

class Habito {
  final String nome;
  final String meta;
  final IconData icone;

  const Habito(this.nome, this.meta, this.icone);
}

class DiarioApp extends StatelessWidget {
  const DiarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Hábitos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaHabitos(),
    );
  }
}

class TelaHabitos extends StatefulWidget {
  const TelaHabitos({super.key});

  @override
  State<TelaHabitos> createState() => _TelaHabitosState();
}

class _TelaHabitosState extends State<TelaHabitos> {
  late Future<List<Habito>> _futureHabitos;

  @override
  void initState() {
    super.initState();
    _futureHabitos = carregarHabitos();
  }

  Future<List<Habito>> carregarHabitos() async {
    await Future.delayed(const Duration(seconds: 4));

    return const [
      Habito('Academia', 'Meta: 1 hora e meia por dia', Icons.fitness_center),
      Habito('Futebol', 'Meta: 2 partidas por semana', Icons.sports_soccer),
      Habito('Estudar', 'Meta: 1 hora por dia', Icons.school),
      Habito('Ler', 'Meta: 30 minutos por dia', Icons.menu_book),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Hábitos'),
      ),
      body: FutureBuilder<List<Habito>>(
        future: _futureHabitos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Carregando seus hábitos...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  const Text('Ops! Ocorreu um erro ao carregar.'),
                  Text(
                    'Detalhe: ${snapshot.error}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, color: Colors.grey, size: 64),
                  SizedBox(height: 16),
                  Text('Nenhum hábito cadastrado ainda.'),
                ],
              ),
            );
          }

          final habitosCarregados = snapshot.data!;
          
          return ListView.builder(
            itemCount: habitosCarregados.length,
            itemBuilder: (context, index) {
              final habito = habitosCarregados[index];
              return ListTile(
                leading: Icon(habito.icone, color: Colors.blue),
                title: Text(
                  habito.nome,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(habito.meta),
              );
            },
          );
        },
      ),
    );
  }
}