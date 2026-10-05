import 'package:flutter/foundation.dart';

import '../dados/habitos_repositorio.dart';
import 'habito.dart';

class HabitosStore extends ChangeNotifier {
  HabitosStore(this._repositorio);

  final HabitosRepositorio _repositorio;

  List<Habito> _habitos = [];

  List<Habito> get habitos => List.unmodifiable(_habitos);

  Future<void> carregar() async {
    _habitos = await _repositorio.carregar();

    notifyListeners();
  }

  Future<void> adicionar(Habito habito) async {
    await _repositorio.salvar(habito);

    _habitos = await _repositorio.carregar();

    notifyListeners();
  }

  Future<void> remover(Habito habito) async {
    await _repositorio.remover(habito);

    _habitos = await _repositorio.carregar();

    notifyListeners();
  }
}