
class Editora {
  Editora({
    int? id,
    String? nome,
  }) {
    _id = id;
    _nome = nome;
  }

  Editora.fromJson(dynamic json) {
    _id = json['id'];
    _nome = json['nome'];
  }

  int? _id;
  String? _nome;

  Editora copyWith({
    int? id,
    String? nome,
  }) =>
      Editora(
        id: id ?? _id,
        nome: nome ?? _nome,
      );

  int? get id => _id;

  void setNome(String valor){
    _nome = valor;
  }

  void setId(int valor){
    _id = valor;
  }

  String? get nome => _nome;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nome'] = _nome;
    return map;
  }
}
