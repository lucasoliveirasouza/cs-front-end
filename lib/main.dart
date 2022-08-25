import 'package:csbiblio/services/auth_service.dart';
import 'package:csbiblio/services/autor_service.dart';
import 'package:csbiblio/services/genero_service.dart';
import 'package:csbiblio/services/usuario_service.dart';
import 'package:csbiblio/views/auth/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'services/editora_service.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => UsuarioService()),
      ChangeNotifierProvider(create: (context) => AutorService()),
      ChangeNotifierProvider(create: (context) => EditoraService()),
      ChangeNotifierProvider(create: (context) => GeneroService()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Biblioteca',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AuthCheck(),
    );
  }
}
