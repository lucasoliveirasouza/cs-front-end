import 'IModel.dart';

class Genero extends IModel {
  Genero({
    String? id,
    String? nome,
  }) {
    _id = id;
    _nome = nome;
  }

  Genero.fromJson(dynamic json) {
    _id = json['id'];
    _nome = json['nome'];
  }

  String? _id;
  String? _nome;

  Genero copyWith({
    String? id,
    String? nome,
  }) =>
      Genero(
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
