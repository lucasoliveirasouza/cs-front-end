import 'dart:collection';
import 'dart:convert';

import 'package:csbiblio/models/Autor.dart';
import 'package:csbiblio/util/contantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AutorService extends ChangeNotifier {
  List<Autor> _autores = [];
  final storage = new FlutterSecureStorage();

  UnmodifiableListView<Autor> get autores => UnmodifiableListView(_autores);

  AutorService() {
    _buscarAutores();
  }

  _buscarAutores() async {
    String? value = await storage.read(key: "tokenKey");
    String uri = '${servidor}api/autores';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaAutores = json;

      listaAutores.forEach((autor) {
        Autor at = Autor.fromJson(autor);
        _autores.add(at);
      });
      notifyListeners();
    }
  }

  Future<List<Autor?>?> getAll() async {
    String? value = await storage.read(key: "tokenKey");

    List<Autor> aut = [];
    String uri = '${servidor}api/autores';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaautores = json;

      listaautores.forEach((autor) {
        Autor at = Autor.fromJson(autor);
        aut.add(at);
      });
    }
    return aut;
  }

  Future<Autor?> getById(String id) async {
    Autor? autor;
    String? value = await storage.read(key: "tokenKey");
    String uri = '${servidor}api/autor/${id}';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      Autor at = Autor.fromJson(json);
      //print(gr.nome);
      return at;
    }
    return autor;
  }

  Future<String> cadastrarAutor(String nome) async {
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.post(
      Uri.parse('${servidor}api/autor'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: jsonEncode(<String, String>{
        'nome': nome,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final autor = json;
      Autor aut = Autor.fromJson(autor);
      _autores.add(aut);
      notifyListeners();

      return "Cadatrado com sucesso";
    } else {
      return "Não foi possível realizar o cadastro";
    }
  }

  Future<String> editarAutor(Autor autor) async {
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.put(
      Uri.parse('${servidor}api/autor'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: json.encode(autor.toJson()),
    );

    if (response.statusCode == 200) {
      _autores.forEach((element) {
        if (element.id == autor.id) {
          element.setNome(autor.nome!);
          notifyListeners();
        }
      });
      return "Editado com sucesso";
    } else {
      return "Não foi possível editar";
    }
  }

  Future<String> deletarAutor(String id) async {
    print(id);
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.delete(
      Uri.parse('${servidor}api/autor/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
    );

    if (response.statusCode == 200) {
      _autores.removeWhere((element) => element.id.toString() == id);
      notifyListeners();
      return "Deletado com sucesso";
    } else {
      return "Não foi possível deletar";
    }
  }
}
