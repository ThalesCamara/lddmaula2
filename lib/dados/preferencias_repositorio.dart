import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasRepositorio {
  Future<void> salvarTema(bool escuro) async {
    final prefs = await SharedPreferences.getInstance();
    final salvo = await prefs.setBool('tema_escuro', escuro);
    if (!salvo) {
      throw StateError('Não foi possível salvar o tema.');
    }
  }

  Future<bool> lerTema() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('tema_escuro') ?? false;
  }
}
