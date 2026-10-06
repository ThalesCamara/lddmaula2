import 'package:flutter/material.dart';

import 'tela_habitos.dart';
import 'tela_resumo.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _abaAtual = 0;

  final List<Widget> _telas = const [
    TelaHabitos(),
    TelaResumo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_abaAtual],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaAtual,

        onTap: (indice) {
          setState(() {
            _abaAtual = indice;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Hábitos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Resumo',
          ),
        ],
      ),
    );
  }
}
