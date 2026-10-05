import '../dominio/habito.dart';

class HabitosRepositorio {
  final List<Habito> _memoria = [
    const Habito(
      'Academia',
      'Meta: 1 hora e meia por dia',
      TipoIconeHabito.academia,
    ),
    const Habito(
      'Futebol',
      'Meta: 2 partidas por semana',
      TipoIconeHabito.esporte,
    ),
    const Habito(
      'Estudar',
      'Meta: 1 hora por dia',
      TipoIconeHabito.estudo,
    ),
    const Habito(
      'Ler',
      'Meta: 30 minutos por dia',
      TipoIconeHabito.leitura,
    ),
  ];

  Future<List<Habito>> carregar() async {
    return List.of(_memoria);
  }

  Future<void> salvar(Habito habito) async {
    _memoria.add(habito);
  }

  Future<void> remover(Habito habito) async {
    _memoria.remove(habito);
  }
}