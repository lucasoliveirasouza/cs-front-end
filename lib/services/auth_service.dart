import 'dart:convert';
import 'package:csbiblio/services/usuario_service.dart';
import 'package:csbiblio/util/contantes.dart';
import 'package:csbiblio/views/menu/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthService extends ChangeNotifier {
  String _token = "";
  bool isLoading = true;
  final storage = new FlutterSecureStorage();

  Future<String> logar(String usuario, String senha) async {
    final storage = new FlutterSecureStorage();
    final http.Response response = await http.post(
      Uri.parse("${servidor}api/auth/signin"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:
          jsonEncode(<String, String>{"password": senha, "username": usuario}),
    );
    if (response.statusCode == 200) {
      _token = jsonDecode(response.body)["accessToken"];
      await storage.write(key: "tokenKey", value: _token);
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UsuarioService()),
        ],
      );
      Get.to(() => MenuView());
      return "Seja bem-vindo";
    } else {
      return "Existe algum erro com suas credenciais";
    }
  }

  Future<String> registrar(String usuario, String email, String senha) async {
    final http.Response response = await http.post(
      Uri.parse("${servidor}api/auth/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": senha,
        "username": usuario
      }),
    );
    print(jsonDecode(response.body)["message"]);
    return jsonDecode(response.body)["message"] ??
        "Não foi possível realizar o cadastro";
  }

  logout() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "tokenKey");
  }
}
