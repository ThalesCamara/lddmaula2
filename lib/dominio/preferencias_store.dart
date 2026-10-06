import 'package:flutter/foundation.dart';

import '../dados/preferencias_repositorio.dart';

class PreferenciasStore extends ChangeNotifier {
  PreferenciasStore(this._repositorio, this._temaEscuro);

  final PreferenciasRepositorio _repositorio;
  bool _temaEscuro;

  bool get temaEscuro => _temaEscuro;

  Future<void> alternarTema() async {
    final novoTema = !_temaEscuro;
    await _repositorio.salvarTema(novoTema);
    _temaEscuro = novoTema;
    notifyListeners();
  }
}
