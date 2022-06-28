import 'dart:collection';
import 'dart:convert';
import 'package:csbiblio/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UsuarioService  extends ChangeNotifier{
  List<Usuario> _usuarios = [];
  final storage = new FlutterSecureStorage();

  UnmodifiableListView<Usuario> get usuarios => UnmodifiableListView(_usuarios);

  UsuarioService() {
    _buscarUsuarios();
  }

  _buscarUsuarios() async {
    String? value = await storage.read(key: "tokenKey");
    String uri = 'https://biblioteca-cs2022.herokuapp.com/api/auth/users';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });


    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaUsuarios = json;

      listaUsuarios.forEach((usuario) {
        print(usuario["id"]);
        Usuario user = Usuario(usuario["id"].toString(), usuario["username"], usuario["email"] );
        _usuarios.add(user);
      });
      notifyListeners();
    }
  }
}