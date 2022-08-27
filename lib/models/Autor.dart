import 'IModel.dart';

class Autor extends IModel {
  Autor({
    String? id,
    String? nome,
  }) {
    _id = id;
    _nome = nome;
  }

  Autor.fromJson(dynamic json) {
    _id = json['id'].toString();
    _nome = json['nome'];
  }

  String? _id;
  String? _nome;

  Autor copyWith({
    String? id,
    String? nome,
  }) =>
      Autor(
        id: id ?? _id,
        nome: nome ?? _nome,
      );

  String? get id => _id;

  void setNome(String valor) {
    _nome = valor;
  }

  void setId(String valor) {
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
