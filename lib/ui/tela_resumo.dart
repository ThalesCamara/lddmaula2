import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dominio/habitos_store.dart';

class TelaResumo extends StatelessWidget {
  const TelaResumo({super.key});

  @override
  Widget build(BuildContext context) {
    final quantidade =
        context.watch<HabitosStore>().habitos.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo'),
      ),

      body: Center(
        child: Text(
          '$quantidade hábitos cadastrados',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}