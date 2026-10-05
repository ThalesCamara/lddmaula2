enum TipoIconeHabito {
  geral,
  academia,
  esporte,
  estudo,
  leitura,
}

class Habito {
  final String nome;
  final String meta;
  final TipoIconeHabito tipoIcone;

  const Habito(
    this.nome,
    this.meta,
    this.tipoIcone,
  );
}