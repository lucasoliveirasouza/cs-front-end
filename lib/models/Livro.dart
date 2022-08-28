import 'Autor.dart';
import 'Editora.dart';
import 'Genero.dart';

class Livro {
  Livro({
    int? id,
    String? nomeSaga,
    String? titulo,
    String? edicao,
    int? anoPublicacao,
    String? codigo,
    int? quantidade,
    Autor? autor,
    Editora? editora,
    List<Genero>? genero,
  }) {
    _id = id;
    _nomeSaga = nomeSaga;
    _titulo = titulo;
  }

  Livro.fromJson(dynamic json) {
    _id = json['id'];
    _nomeSaga = json['nomeSaga'];
    _titulo = json['titulo'];
    _edicao = json['edicao'];
    _anoPublicacao = json['anoPublicacao'];
    _codigo = json['codigo'];
    _quantidade = json['quantidade'];
    _autor = (json['autor'] != null ? Autor.fromJson(json['autor']) : null)!;
    _editora =
        (json['editora'] != null ? Editora.fromJson(json['editora']) : null)!;
    if (json['genero'] != null) {
      _genero = [];
      json['genero'].forEach((v) {
        _genero?.add(Genero.fromJson(v));
      });
    }
  }
  int? _id;
  String? _nomeSaga;
  String? _titulo;
  String? _edicao;
  int? _anoPublicacao;
  String? _codigo;
  int? _quantidade;
  Autor? _autor;
  Editora? _editora;
  List<Genero>? _genero;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nomeSaga'] = _nomeSaga;
    map['titulo'] = _titulo;
    map['edicao'] = _edicao;
    map['anoPublicacao'] = _anoPublicacao;
    map['codigo'] = _codigo;
    map['quantidade'] = _quantidade;
    if (_autor != null) {
      map['autor'] = _autor!.toJson();
    }
    if (_editora != null) {
      map['editora'] = _editora!.toJson();
    }
    if (_genero != null) {
      map['genero'] = _genero!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
