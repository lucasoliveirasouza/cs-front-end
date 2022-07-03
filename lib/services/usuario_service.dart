import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'package:csbiblio/models/Role.dart';
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

  Future<String> editarUsuario(Usuario user,String usuario, String email, String funcao) async {
    Role role = Role();
    if (funcao == "Usuário") {
      role.setName("ROLE_USER");
      role.setId(3);
    } else if (funcao == "Moderador") {
      role.setName("ROLE_MODERATOR");
      role.setId(2);
    } else {
      role.setName("ROLE_ADMIN");
      role.setId(1);
    }

    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.put(
      Uri.parse('${servidor}/api/auth/user'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: jsonEncode(<String, String>{
        "id": user.id.toString(),
        "email": email,
        "username": usuario
      }),
    );

    if (response.statusCode == 200) {
      _usuarios.forEach((element) {
        if (element.id == user.id) {
          element.setUsername(usuario);
          element.setEmail(email);
          notifyListeners();
        }
      });
      return "Editado com sucesso";
    } else {
      return "Não foi possível editar";
    }
  }

  Future<http.Response> deletarUsuario(String id) async {
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.delete(
      Uri.parse('${servidor}/api/auth/user/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
    );

    if (response.statusCode == 200) {
      _usuarios.removeWhere((element) => element.id == id);
      notifyListeners();
    }

    return response;
  }


}
