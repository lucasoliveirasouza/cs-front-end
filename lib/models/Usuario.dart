import 'package:csbiblio/models/Role.dart';

class Usuario {
  Usuario({
    int? id,
    String? username,
    String? email,
    String? password,
    Role? role,
  }) {
    _id = id;
    _username = username;
    _email = email;
    _password = password;
    _role = role;
  }

  Usuario.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _password = json['password'];
    _role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }
  int? _id;
  String? _username;
  String? _email;
  String? _password;
  Role? _role;
  Usuario copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    Role? role,
  }) =>
      Usuario(
        id: id ?? _id,
        username: username ?? _username,
        email: email ?? _email,
        password: password ?? _password,
        role: role ?? _role,
      );
  int? get id => _id;
  String? get username => _username;
  String? get email => _email;
  String? get password => _password;
  Role? get role => _role;

  void setRole(Role role){
    _role = role;
  }

  void setUsername(String user){
    _username = user;
  }

  void setEmail(String mail){
    _email = mail;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['password'] = _password;
    if (_role != null) {
      map['role'] = _role?.toJson();
    }
    return map;
  }
}
