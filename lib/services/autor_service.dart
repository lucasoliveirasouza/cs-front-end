

import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:csbiblio/models/Autor.dart';
import 'package:csbiblio/util/contantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AutorService extends ChangeNotifier{

  List<Autor> _autores = [];
  final storage = new FlutterSecureStorage();

  UnmodifiableListView<Autor> get autores => UnmodifiableListView(_autores);

  AutorService() {
    _buscarAutores();
  }

  _buscarAutores() async {
    String? value = await storage.read(key: "token");
    print(value);
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


  Future<String> cadastrarAutor(String nome) async {
    String? value = await storage.read(key: "token");
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

  Future<String> editarAutor(String id, String nome) async {
    String? value = await storage.read(key: "token");
    final http.Response response = await http.put(
      Uri.parse('${servidor}api/autor'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'nome': nome,
      }),
    );

    if (response.statusCode == 200) {
      _autores.forEach((element) {
        if (element.id == id) {
          element.nome = nome;
          notifyListeners();
        }
      });
      return "Editado com sucesso";
    } else {
      return "Não foi possível editar";
    }
  }

  Future<http.Response> deletarAutor(String id) async {
    String? value = await storage.read(key: "token");
    final http.Response response = await http.delete(
      Uri.parse('${servidor}api/autor/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
    );

    _autores.removeWhere((element) => element.id == id);
    notifyListeners();
    return response;
  }
}