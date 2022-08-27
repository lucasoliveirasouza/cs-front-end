import 'IModel.dart';

class Editora extends IModel {
  Editora({
    String? id,
    String? nome,
  }) {
    _id = id;
    _nome = nome;
  }

  Editora.fromJson(dynamic json) {
    _id = json['id'].toString();
    _nome = json['nome'];
  }

  String? _id;
  String? _nome;

  Editora copyWith({
    String? id,
    String? nome,
  }) =>
      Editora(
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
