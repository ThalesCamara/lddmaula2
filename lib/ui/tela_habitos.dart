import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dominio/habito.dart';
import '../dominio/habitos_store.dart';
import 'tela_detalhe.dart';

class TelaHabitos extends StatelessWidget {
  const TelaHabitos({super.key});

  IconData _iconeDoHabito(TipoIconeHabito tipo) {
    switch (tipo) {
      case TipoIconeHabito.academia:
        return Icons.fitness_center;

      case TipoIconeHabito.esporte:
        return Icons.sports_soccer;

      case TipoIconeHabito.estudo:
        return Icons.school;

      case TipoIconeHabito.leitura:
        return Icons.menu_book;

      case TipoIconeHabito.geral:
        return Icons.check_circle_outline;
    }
  }

  void _abrirNovoHabito(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/novo',
    );
  }

  @override
  Widget build(BuildContext context) {
    final habitos = context.watch<HabitosStore>().habitos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Hábitos'),
      ),

      body: habitos.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    color: Colors.grey,
                    size: 64,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum hábito cadastrado ainda.',
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: habitos.length,

              itemBuilder: (context, index) {
                final habito = habitos[index];

                return ListTile(
                  leading: Icon(
                    _iconeDoHabito(habito.tipoIcone),
                    color: Colors.blue,
                  ),

                  title: Text(
                    habito.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    habito.meta,
                  ),

                  trailing: const Icon(
                    Icons.chevron_right,
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TelaDetalhe(
                          habito: habito,
                        ),
                      ),
                    );
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirNovoHabito(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}