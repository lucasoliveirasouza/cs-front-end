import 'Autor.dart';
import 'Editora.dart';
import 'Genero.dart';

class Livro {
  Livro({
    required this.id,
    required this.nomeSaga,
    required this.titulo,
    required this.edicao,
    required this.anoPublicacao,
    required this.codigo,
    required this.quantidade,
    required this.autor,
    required this.editora,
    required this.genero,
  });

  Livro.fromJson(dynamic json) {
    id = json['id'];
    nomeSaga = json['nomeSaga'];
    titulo = json['titulo'];
    edicao = json['edicao'];
    anoPublicacao = json['anoPublicacao'];
    codigo = json['codigo'];
    quantidade = json['quantidade'];
    autor = (json['autor'] != null ? Autor.fromJson(json['autor']) : null)!;
    editora =
        (json['editora'] != null ? Editora.fromJson(json['editora']) : null)!;
    if (json['genero'] != null) {
      genero = [];
      json['genero'].forEach((v) {
        genero?.add(Genero.fromJson(v));
      });
    }
  }
  int? id;
  String? nomeSaga;
  String? titulo;
  String? edicao;
  int? anoPublicacao;
  String? codigo;
  int? quantidade;
  Autor? autor;
  Editora? editora;
  List<Genero>? genero;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['nomeSaga'] = nomeSaga;
    map['titulo'] = titulo;
    map['edicao'] = edicao;
    map['anoPublicacao'] = anoPublicacao;
    map['codigo'] = codigo;
    map['quantidade'] = quantidade;
    if (autor != null) {
      map['autor'] = autor!.toJson();
    }
    if (editora != null) {
      map['editora'] = editora!.toJson();
    }
    if (genero != null) {
      map['genero'] = genero!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
