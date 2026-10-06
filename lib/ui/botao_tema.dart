import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dominio/preferencias_store.dart';

class BotaoTema extends StatelessWidget {
  const BotaoTema({super.key});

  @override
  Widget build(BuildContext context) {
    final escuro = context.watch<PreferenciasStore>().temaEscuro;
    return IconButton(
      tooltip: escuro ? 'Usar tema claro' : 'Usar tema escuro',
      icon: Icon(escuro ? Icons.light_mode : Icons.dark_mode),
      onPressed: () async {
        try {
          await context.read<PreferenciasStore>().alternarTema();
        } catch (_) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Não foi possível salvar o tema.')),
          );
        }
      },
    );
  }
}
