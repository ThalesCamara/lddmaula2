enum TipoIconeHabito { geral, academia, esporte, estudo, leitura }

class Habito {
  final int? id;
  final String nome;
  final String meta;
  final TipoIconeHabito tipoIcone;

  const Habito({
    this.id,
    required this.nome,
    required this.meta,
    this.tipoIcone = TipoIconeHabito.geral,
  });

  Map<String, Object?> toMap() => {
    'id': id,
    'nome': nome,
    'meta': meta,
    'tipo_icone': tipoIcone.name,
  };

  factory Habito.fromMap(Map<String, Object?> mapa) => Habito(
    id: mapa['id'] as int?,
    nome: mapa['nome'] as String,
    meta: mapa['meta'] as String,
    tipoIcone: TipoIconeHabito.values.byName(mapa['tipo_icone'] as String),
  );
}
