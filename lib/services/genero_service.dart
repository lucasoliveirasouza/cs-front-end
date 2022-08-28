import 'dart:collection';
import 'dart:convert';

import 'package:csbiblio/models/Genero.dart';
import 'package:csbiblio/util/contantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GeneroService extends ChangeNotifier {
  List<Genero> _generos = [];
  final storage = new FlutterSecureStorage();

  UnmodifiableListView<Genero> get generos => UnmodifiableListView(_generos);

  GeneroService() {
    _buscarGeneros();
  }

  _buscarGeneros() async {
    String? value = await storage.read(key: "tokenKey");
    String uri = '${servidor}api/generos';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaGeneros = json;

      listaGeneros.forEach((genero) {
        Genero gr = Genero.fromJson(genero);
        _generos.add(gr);
      });
      notifyListeners();
    }
  }

  Future<List<Genero?>?> getAll() async {
    String? value = await storage.read(key: "tokenKey");

    List<Genero> gen = [];
    String uri = '${servidor}api/generos';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaautores = json;

      listaautores.forEach((autor) {
        Genero gr = Genero.fromJson(autor);
        gen.add(gr);
      });
    }
    return gen;
  }

  Future<Genero?> getById(String id) async {
    Genero? genero;
    String? value = await storage.read(key: "tokenKey");
    String uri = '${servidor}api/genero/${id}';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      Genero gr = Genero.fromJson(json);
      //print(gr.nome);
      return gr;
    }
    return genero;
  }

  Future<String> cadastrarGenero(String nome) async {
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.post(
      Uri.parse('${servidor}api/genero'),
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
      final genero = json;
      Genero aut = Genero.fromJson(genero);
      _generos.add(aut);
      notifyListeners();

      return "Cadastrado com sucesso";
    } else {
      return "Não foi possível realizar o cadastro";
    }
  }

  Future<String> editarGenero(Genero genero) async {
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.put(
      Uri.parse('${servidor}api/genero'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: json.encode(genero.toJson()),
    );

    if (response.statusCode == 200) {
      _generos.forEach((element) {
        if (element.id == genero.id) {
          element.setNome(genero.nome!);
          notifyListeners();
        }
      });
      return "Editado com sucesso";
    } else {
      return "Não foi possível editar";
    }
  }

  Future<String> deletarGenero(String id) async {
    print(id);
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.delete(
      Uri.parse('${servidor}api/genero/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
    );

    if (response.statusCode == 200) {
      _generos.removeWhere((element) => element.id.toString() == id);
      notifyListeners();
      return "Deletado com sucesso";
    } else {
      return "Não foi possível deletar";
    }
  }
}
