import 'dart:convert';

import 'package:room_agenda/src/features/login/login.dart';

class UsuarioModel extends Usuario {
  const UsuarioModel({
    required String name,
    required String email,
    required String photoUrl,
    required List<String> cnpjs,
  }) : super(
          name: name,
          email: email,
          photoUrl: photoUrl,
          cnpjs: cnpjs,
        );

  UsuarioModel copyWith({
    String? name,
    String? email,
    String? photoUrl,
    List<String>? cnpjs,
  }) {
    return UsuarioModel(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      cnpjs: cnpjs ?? this.cnpjs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'cnpjs': cnpjs,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      cnpjs: List.from(map['cnpjs'] ?? []),
    );
  }

  Usuario toEntity() {
    return Usuario(name: name, email: email, photoUrl: photoUrl, cnpjs: cnpjs);
  }

  factory UsuarioModel.fromEntity(Usuario usuario) {
    return UsuarioModel(
      name: usuario.name,
      email: usuario.email,
      photoUrl: usuario.photoUrl,
      cnpjs: usuario.cnpjs,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
