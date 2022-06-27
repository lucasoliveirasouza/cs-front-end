import 'package:csbiblio/views/auth/login.dart';
import 'package:csbiblio/views/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final storage = new FlutterSecureStorage();
  String? value;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    obtemTokem();
  }

  @override
  Widget build(BuildContext context) {

    if(isLoading){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else if(value == null){
      return LoginView();
    }else{
      return MenuView();
    }

  }
  obtemTokem() async{
    value = await storage.read(key: "tokenKey");
    setState(() {
      isLoading = false;
    });

  }
}
