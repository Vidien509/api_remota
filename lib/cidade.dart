class Cidade {
  final String nome;
  final String estado;
  final int populacao;
  final int areaKm2;

  Cidade({
    required this.nome,
    required this.estado,
    required this.populacao,
    required this.areaKm2,
  });

  factory Cidade.fromJson(Map<String, dynamic> json) {
    return Cidade(
      nome: json['nome'],
      estado: json['estado'],
      populacao: json['populacao'],
      areaKm2: json['area_km2'],
    );
  }
}
