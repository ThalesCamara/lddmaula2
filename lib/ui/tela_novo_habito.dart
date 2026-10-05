import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dominio/habito.dart';
import '../dominio/habitos_store.dart';

class TelaNovoHabito extends StatefulWidget {
  const TelaNovoHabito({super.key});

  @override
  State<TelaNovoHabito> createState() => _TelaNovoHabitoState();
}

class _TelaNovoHabitoState extends State<TelaNovoHabito> {
  final _chaveForm = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _metaController = TextEditingController();

  TipoIconeHabito _iconeSelecionado = TipoIconeHabito.geral;

  @override
  void dispose() {
    _nomeController.dispose();
    _metaController.dispose();

    super.dispose();
  }

  Future<void> _salvarHabito() async {
    if (_chaveForm.currentState!.validate()) {
      final novoHabito = Habito(
        _nomeController.text.trim(),
        'Meta: ${_metaController.text.trim()}',
        _iconeSelecionado,
      );

      await context.read<HabitosStore>().adicionar(
            novoHabito,
          );

      if (!mounted) return;

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Hábito'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _chaveForm,

          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,

                decoration: const InputDecoration(
                  labelText: 'Nome do hábito',
                  border: OutlineInputBorder(),
                ),

                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Digite o nome do hábito';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _metaController,

                decoration: const InputDecoration(
                  labelText: 'Meta',
                  hintText: 'Ex: 1 hora por dia',
                  border: OutlineInputBorder(),
                ),

                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Digite uma meta';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<TipoIconeHabito>(
                initialValue: _iconeSelecionado,

                decoration: const InputDecoration(
                  labelText: 'Ícone',
                  border: OutlineInputBorder(),
                ),

                items: const [
                  DropdownMenuItem(
                    value: TipoIconeHabito.geral,
                    child: Text('Geral'),
                  ),

                  DropdownMenuItem(
                    value: TipoIconeHabito.academia,
                    child: Text('Academia'),
                  ),

                  DropdownMenuItem(
                    value: TipoIconeHabito.esporte,
                    child: Text('Esporte'),
                  ),

                  DropdownMenuItem(
                    value: TipoIconeHabito.estudo,
                    child: Text('Estudo'),
                  ),

                  DropdownMenuItem(
                    value: TipoIconeHabito.leitura,
                    child: Text('Leitura'),
                  ),
                ],

                onChanged: (tipo) {
                  if (tipo != null) {
                    setState(() {
                      _iconeSelecionado = tipo;
                    });
                  }
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,

                child: FilledButton(
                  onPressed: _salvarHabito,
                  child: const Text(
                    'Salvar',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}