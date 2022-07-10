
class Autor {
  Autor({
    int? id,
    String? nome,
  }) {
    _id = id;
    _nome = nome;
  }

  Autor.fromJson(dynamic json) {
    _id = json['id'];
    _nome = json['name'];
  }

  int? _id;
  String? _nome;

  Autor copyWith({
    int? id,
    String? nome,
  }) =>
      Autor(
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
    map['name'] = _nome;
    return map;
  }
}
