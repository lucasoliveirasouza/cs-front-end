import 'dart:collection';
import 'dart:convert';
import 'package:csbiblio/models/Editora.dart';
import 'package:http/http.dart' as http;
import 'package:csbiblio/util/contantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EditoraService extends ChangeNotifier{

  List<Editora> _editoras = [];
  final storage = new FlutterSecureStorage();

  UnmodifiableListView<Editora> get editoras => UnmodifiableListView(_editoras);

  EditoraService() {
    _buscarEditoras();
  }

  _buscarEditoras() async {
    String? value = await storage.read(key: "tokenKey");
    String uri = '${servidor}api/editoras';
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${value}"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> listaEditoras = json;

      listaEditoras.forEach((editora) {
        Editora ed = Editora.fromJson(editora);
        _editoras.add(ed);
      });
      notifyListeners();
    }
  }


  Future<String> cadastrarEditora(String nome) async {
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.post(
      Uri.parse('${servidor}api/editora'),
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
      final editora = json;
      Editora edi = Editora.fromJson(editora);
      _editoras.add(edi);
      notifyListeners();

      return "Cadatrado com sucesso";
    } else {
      return "Não foi possível realizar o cadastro";
    }
  }

  Future<String> editarEditora(Editora editora) async {
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.put(
      Uri.parse('${servidor}api/editora'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
      body: json.encode(editora.toJson()),
    );

    if (response.statusCode == 200) {
      _editoras.forEach((element) {
        if (element.id == editora.id) {
          element.setNome(editora.nome!);
          notifyListeners();
        }
      });
      return "Editado com sucesso";
    } else {
      return "Não foi possível editar";
    }
  }

  Future<String> deletarEditora(String id) async {
    print(id);
    String? value = await storage.read(key: "tokenKey");
    final http.Response response = await http.delete(
      Uri.parse('${servidor}api/editora/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${value}"
      },
    );

    if (response.statusCode == 200) {
      _editoras.removeWhere((element) => element.id.toString() == id);
      notifyListeners();
      return "Deletado com sucesso";
    } else {
      return "Não foi possível deletar";
    }


  }
}