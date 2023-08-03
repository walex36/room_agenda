import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String name;
  final String email;
  final String photoUrl;
  final List<String> cnpj;

  const Usuario({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.cnpj,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        photoUrl,
        cnpj,
      ];
}
