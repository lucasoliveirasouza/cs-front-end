import 'dart:collection';
import 'dart:convert';

import 'package:csbiblio/models/Livro.dart';
import 'package:csbiblio/util/contantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LivroService extends ChangeNotifier {
  List<Livro> _livros = [];
  final storage = new FlutterSecureStorage();

  UnmodifiableListView<Livro> get livros => UnmodifiableListView(_livros);

  LivroService() {
    _buscarLivros();
  }

  _buscarLivros() async {
    String? value = await storage.read(key: "tokenKey");
    String uri = '${servidor}api/livro/lista';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaGeneros = json;
      listaGeneros.forEach((genero) {
        Livro lv = Livro.fromJson(genero);
        _livros.add(lv);
      });
      notifyListeners();
    }
  }

  Future<String> cadastrarLivro(Livro livro) async {
    //print(livro.editora?.nome ?? "");
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.post(
      Uri.parse('${servidor}api/livro'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: json.encode(livro.toJson()),
    );

    if (response.statusCode == 200) {
      return "Cadastrado com sucesso";
    } else {
      return "Não foi possível realizar o cadastro";
    }
  }
}
