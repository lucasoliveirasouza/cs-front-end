import 'dart:collection';
import 'dart:convert';
import 'package:csbiblio/models/Usuario.dart';

import 'package:csbiblio/util/contantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UsuarioService extends ChangeNotifier {
  List<Usuario> _usuarios = [];
  final storage = new FlutterSecureStorage();

  UnmodifiableListView<Usuario> get usuarios => UnmodifiableListView(_usuarios);

  UsuarioService() {
    _buscarUsuarios();
  }

  _buscarUsuarios() async {
    _usuarios = [];
    String? value = await storage.read(key: "tokenKey");
    String uri = '${servidor}api/auth/users';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaUsuarios = json;

      listaUsuarios.forEach((usuario) {
        Usuario user = Usuario.fromJson(usuario);
        _usuarios.add(user);
      });
      notifyListeners();
    }
  }

  Future<String> registrarUsuario(
      String usuario, String email, String senha, String role) async {
    String funcao;

    if (role == "Usuário") {
      funcao = "user";
    } else if (role == "Moderador") {
      funcao = "mod";
    } else {
      funcao = "admin";
    }
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.post(
      Uri.parse("${servidor}api/auth/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": senha,
        "username": usuario,
        "role": funcao
      }),
    );

    _buscarUsuarios();
    notifyListeners();

    return jsonDecode(response.body)["message"] ??
        "Não foi possível realizar o cadastro";
  }
}
