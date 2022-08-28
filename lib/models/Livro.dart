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
    _edicao = edicao;
    _anoPublicacao = anoPublicacao;
    _codigo = codigo;
    _quantidade = quantidade;
    _autor = autor;
    _editora = editora;
    _genero = genero;
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

  int? get id => _id;

  void setId(int value) {
    _id = value;
  }

  String? get nomeSaga => _nomeSaga;

  void setNomeSaga(String value) {
    _nomeSaga = value;
  }

  String? get titulo => _titulo;

  void setTitulo(String value) {
    _titulo = value;
  }

  String? get edicao => _edicao;

  void setEdicao(String value) {
    _edicao = value;
  }

  int? get anoPublicacao => _anoPublicacao;

  void setAnoPublicacao(int value) {
    _anoPublicacao = value;
  }

  String? get codigo => _codigo;

  void setCodigo(String value) {
    _codigo = value;
  }

  int? get quantidade => _quantidade;

  void setQuantidade(int value) {
    _quantidade = value;
  }

  Autor? get autor => _autor;

  void setAutor(Autor value) {
    _autor = value;
  }

  Editora? get editora => _editora;

  void setEditora(Editora value) {
    _editora = value;
  }

  List<Genero>? get genero => _genero;

  void setGenero(List<Genero> value) {
    _genero = value;
  }
}
