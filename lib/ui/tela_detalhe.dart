import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dominio/habito.dart';
import '../dominio/habitos_store.dart';

class TelaDetalhe extends StatelessWidget {
  const TelaDetalhe({
    super.key,
    required this.habito,
  });

  final Habito habito;

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

  Future<void> _excluir(BuildContext context) async {
    await context.read<HabitosStore>().remover(habito);

    if (!context.mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habito.nome),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Icon(
                _iconeDoHabito(habito.tipoIcone),
                size: 80,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              habito.nome,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              habito.meta,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: FilledButton.icon(
                onPressed: () {
                  _excluir(context);
                },

                icon: const Icon(
                  Icons.delete,
                ),

                label: const Text(
                  'Excluir',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}